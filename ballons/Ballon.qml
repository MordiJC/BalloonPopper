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

    width: 100
    height: 50
    color: "black"
	antialiasing: true

    Body {
        id: rootBody
        world: gameWorld
        target: root
        bodyType: Body.Dynamic

        Box {
            id: box
			objectName: root.objectName
            width: root.width
            height: root.height
            density: 0.5
            restitution: 0.5
            friction: 0.5
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
		}
		onPressed: {
			if (draggable) {
				mouseDragJoint.maxForce = rootBody.getMass() * 500
				mouseDragJoint.target = Qt.point(mapToItem(null, mouseX, mouseY).x, mapToItem(null, mouseX, mouseY).y)
				mouseDragJoint.bodyB = rootBody;
			}
		}
		onPositionChanged: {
			if (draggable) {
				mouseDragJoint.maxForce = rootBody.getMass() * 500
				mouseDragJoint.target = Qt.point(mapToItem(null, mouseX, mouseY).x, mapToItem(null, mouseX, mouseY).y)
				mouseDragJoint.bodyB = rootBody
			}
		}
		onReleased: draggable ? mouseDragJoint.bodyB = null : 0
	}
}

