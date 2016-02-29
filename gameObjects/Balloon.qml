import QtQuick 2.0
import Box2D 2.0

PhysicsItem {
	id: balloonRoot
	signal clicked

	MouseArea {
		id: balloonMouseArea

		anchors.fill: parent
	}

}
