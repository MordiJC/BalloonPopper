import QtQuick 2.0
import Box2D 2.0

Rectangle {
    id: root
	objectName: "ballon"
	property bool draggable: true
	property World gameWorld: undefined

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
			//width: root.width
			//height: root.height
			radius: 25
			density: -100
			restitution: 0.1
			friction: 0.1
			onBeginContact: console.log("Ballon contact with: ", other.objectName)
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
	MouseArea {
		anchors.fill: parent
		propagateComposedEvents: true
		onClicked: {
			console.log("Clicked objectName: ", root.objectName)
			root.clicked()
			root.destroy()
			game.points+=10
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

