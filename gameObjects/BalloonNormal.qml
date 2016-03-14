import QtQuick 2.5
import Box2D 2.0

Balloon {
	id: balloonNormalRoot
	onReleased: {
		destroyAnim.start()
		dataWorld.pointsReceieved(50)
	}
}

