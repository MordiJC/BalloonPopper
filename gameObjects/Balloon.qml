import QtQuick 2.0
import Box2D 2.0

PhysicsItem {
	id: balloonRoot

	objectName: "balloon"
	width: 50
	height: 60
	property bool draggable: true
	property var gameWorld: undefined
	physicsWorld: gameWorld

	property int points: 10

	signal clicked

	function setXY(x,y) {
		balloonRoot.x = x
		balloonRoot.y = y
	}

	Rectangle {
		anchors.fill: parent
		width: 50
		height: 60
		color: "red"
		opacity: 0.7
		radius: 25
		antialiasing: true
	}

	Body {
		id: rootBody
		world: gameWorld
		target: balloonRoot
		bodyType: Body.Dynamic
		Circle {
			id: box
			objectName: balloonRoot.objectName
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
		target: balloonRoot
		property: "scale"
		from: 1
		to: 1.2
		duration: 150
		easing.type: Easing.InBounce
		onStopped: ballonRoot.destroy()
	}

	MouseArea {
		anchors.fill: parent
		propagateComposedEvents: true
		onClicked: {
			console.log("Clicked objectName: ", balloonRoot.objectName)
			balloonRoot.clicked()
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
