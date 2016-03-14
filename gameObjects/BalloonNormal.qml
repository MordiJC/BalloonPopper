import QtQuick 2.5
import Box2D 2.0

import "../gameObjects" as GameObjects

Balloon {
	id: balloonNormalRoot
	property string pointsText
	points: 50
	onReleased: {
		destroyAnim.start()
		textPoints.showPoints()
		dataWorld.pointsReceieved(points)
	}

	GameObjects.TextBalloonPoints {
		id: textPoints
		size: 40
		pointsText: "+" + points
	}
}

