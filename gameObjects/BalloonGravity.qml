import QtQuick 2.0
import Box2D 2.0

import "../gameObjects" as GameObjects

Balloon {
	id: balloonNormalRoot
	property string pointsText
	points: 100
	onReleased: {
		destroyAnim.start()
		textPoints.showPoints()
		dataWorld.pointsReceieved(points)
		gameWorld.gravity = Qt.point(-3, 0)
	}

	GameObjects.TextBalloonPoints {
		id: textPoints
		size: 40
		pointsText: "+" + points
	}

}

