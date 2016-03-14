import QtQuick 2.5
import Box2D 2.0

PhysicsItem {
	id: balloonRoot
	objectName: "balloon"
	width: balloonWidth
	height: balloonHeight
	property color color: "red"
	property real balloonOpacity: 1
	property int balloonHeight: 60
	property int balloonWidth: 50
	property bool draggable: true
	property alias gameWorld: balloonRoot.physicsWorld
	property GameWorld dataWorld
	property string imageSource: ""

	property int points

	property alias destroyAnim: animDestroy

	property int pointsAlias

	signal clicked
	signal pressed
	signal released
	signal positionChanged
	signal ballonDestroyed

	function setXY(x,y) {
		balloonRoot.x = x
		balloonRoot.y = y
	}

	state: "RECT_BALLON"
	Rectangle {
		id: rectRepresentation
		visible: true
		anchors.fill: parent
		width: balloonWidth
		height: balloonHeight
		color: parent.color
		opacity: balloonOpacity
		radius: width/2
		antialiasing: true
	}
	Image {
		id: imageRepresentation
		visible: false
		source: parent.imageSource
	}

	Body {
		id: rootBody
		world: gameWorld
		target: balloonRoot
		bodyType: Body.Dynamic
		Circle {
			id: box
			objectName: balloonRoot.objectName
			radius: rectRepresentation.radius
			density: -100
			restitution: 0.1
			friction: 0.1
			onBeginContact: {
				if(other.objectName == "wallUp") {
					ballonDestroyed()
					balloonRoot.destroy();
				}
			}
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
		duration: 350
		easing.type: Easing.InBounce
		onStopped: balloonRoot.destroy()
	}

	MouseArea {
		anchors.fill: parent
		propagateComposedEvents: true
		onClicked: {
			console.log("Clicked objectName: ", balloonRoot.objectName)
			balloonRoot.clicked()
		}
		onPressed: {
			if (draggable) {
				mouseDragJoint.maxForce = rootBody.getMass() * 15
				mouseDragJoint.target = Qt.point(mapToItem(null, mouseX, mouseY).x, mapToItem(null, mouseX, mouseY).y)
				mouseDragJoint.bodyB = rootBody;
			}
			balloonRoot.pressed()
		}
		onPositionChanged: {
			if (draggable) {
				mouseDragJoint.maxForce = rootBody.getMass() * 15
				mouseDragJoint.target = Qt.point(mapToItem(null, mouseX, mouseY).x, mapToItem(null, mouseX, mouseY).y)
				mouseDragJoint.bodyB = rootBody
				parent.positionChanged()
			}
		}
		onReleased: {
			draggable ? mouseDragJoint.bodyB = null : 0
			balloonRoot.released()
		}
	}

	states: [
		State {
			name: "IMAGE_BALLON"
			PropertyChanges {
				target: rectRepresentation
				visible: false
			}
			PropertyChanges {
				target: imageRepresentation
				visible: true
			}
		},
		State {
			name: "RECT_BALLON"
			PropertyChanges {
				target: rectRepresentation
				visible: true
			}
			PropertyChanges {
				target: imageRepresentation
				visible: false
			}
		}
	]
}
