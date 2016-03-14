import QtQuick 2.5
import Box2D 2.0

Rectangle {
    id: root
	objectName: "balloon"
	property bool draggable: true
	property World gameWorld: undefined

	property int points: 10

	signal clicked

    function setXY(x,y) {
        root.x = x
        root.y = y
    }

	width: 50
	height: 60
	color: "red"
	opacity: 0.7
	radius: 25
	antialiasing: true

    Body {
        id: rootBody
        world: gameWorld
        target: root
		bodyType: Body.Dynamic
		Circle {
            id: box
			objectName: root.objectName
			radius: 25
			density: -100
			restitution: 0.1
			friction: 0.1
			onBeginContact: console.log("Balloon contact with: ", other.objectName)
        }
    }
	Body {
		id: mouseAnchor
		sleepingAllowed: draggable
		active: draggable
		world: gameWorld
	}
	MouseJoint {
		id: mouseDragJoint
		bodyA: mouseAnchor
		dampingRatio: 0.8
		maxForce: 100
	}
	PropertyAnimation {
		id: animDestroy
		target: root
		property: "scale"
		from: 1
		to: 1.2
		duration: 1500
		easing.type: Easing.InBounce
		onStopped: root.destroy()
	}

	MouseArea {
		anchors.fill: parent
		propagateComposedEvents: true
		onClicked: {
			console.log("Clicked objectName: ", root.objectName)
			root.clicked()
			animDestroy.start()
		}
		onPressed: {
			if (draggable) {
				mouseDragJoint.maxForce = rootBody.getMass() * 15
				mouseDragJoint.target = Qt.point(mapToItem(null, mouseX, mouseY).x, mapToItem(null, mouseX, mouseY).y)
				mouseDragJoint.bodyB = rootBody;
			}
		}
		onPositionChanged: {
			if (draggable) {
				mouseDragJoint.maxForce = rootBody.getMass() * 15
				mouseDragJoint.target = Qt.point(mapToItem(null, mouseX, mouseY).x, mapToItem(null, mouseX, mouseY).y)
				mouseDragJoint.bodyB = rootBody
			}
		}
		onReleased: draggable ? mouseDragJoint.bodyB = null : 0
	}
}

