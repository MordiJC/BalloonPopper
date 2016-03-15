import QtQuick 2.0
import Box2D 2.0

import "../gameObjects" as WorldObjects

import "../scripts/utility.js" as Utility

/**
 * GameWorld.qml - Plik zawiera "Świat Gry", który zawiera
 * wszystkie elementy rozgrywki.
 */
Item {
	id: rootGameWorld
	anchors.fill: parent

	property var balloonsComponent: Qt.createComponent("../gameObjects/Balloon.qml");
	property Component balloonNormalObj: Qt.createComponent("../gameObjects/BalloonNormal.qml")
	property Component balloonGravityObj: Qt.createComponent("../gameObjects/BalloonGravity.qml")

	/**
	 * Zmienna używana do ustalenia położenia górnej ściany wykrywającej,
	 * czy balon wyleciał poza obszar widoczny dla gracza.
	 */
	property int balloonBoxHeight: 60

	/**
	 * Tablica na obiekty, które powinny być nadzorowane w czasie gry.
	 * Objiekty będą rozróżniane po typie zapisanym w zmiennej objectName
	 * oraz po referencji zapisanej w poniższej tablicy.
	 */
	property var objects: []

	/**
	 * Zmienna przechowuje ilość punktów zdobytych przez gracza.
	 * Użycie: dodać Connection na onPointsChanged w obiekcie zewnętrznym.
	 */
	property int points: 0
	onPointsChanged: console.log("Points changed to: ", points)

	// Minimalny interwał tworzenia nowych balonów.
	property int minSpawnTime: 200
	// Maksymnalny iterwał tworzenia nowych balonów.
	property int maxSpawnTime: 300

	// Maksymalnny x dla tworzenia nowych balonów.
	property int maxSpawnXPos: parent.width - 50

	// Maksymalna ilość balonów
	property int maxBalloons: 200

	// Ilość utworzonych balonów na planszy
	property int ballonSpawned: 0

	// Sygnał informujący o uzyskaniu punktów.
	signal pointsReceieved(int pkt)
	onPointsReceieved: {
		points += pkt
		statusBar.updateStatusBarValue("Points: ", points)
	}

	// Sygnał informujacy o uzyskaniu bonusu.
	signal bonusReceieved(string bonusName)

	/**
	 * Obiekt świata fizycznego, w którym będą przeprowadzane obliczenia.
	 */
	World {
		id: gameWorld
		property point normalGravity: Qt.point(0, -1)
		gravity: normalGravity
		onGravityChanged: timerGravityBack.start()
		Component.onCompleted: balloonSpawnTimer.start()
	}
	Timer {
		id: timerGravityBack
		interval: 1000
		repeat: false
		onTriggered: {
			gameWorld.gravity = gameWorld.normalGravity
			stop()
		}
	}

	/**
	 * Timer przeznaczony do dodawania nowych balonów do obszaru gry
	 * co określony zakres czasu.
	 */
	Timer {
		id: balloonSpawnTimer
		running: true
		repeat: true
		interval: Utility.getRandomInt(minSpawnTime, maxSpawnTime);
		onTriggered: {
			if (ballonSpawned <= maxBalloons) {
				interval = Utility.getRandomInt(minSpawnTime, maxSpawnTime);
				var color1 = Qt.rgba(Utility.getRandomFloat(0, 1), Utility.getRandomFloat(0, 0.5), Utility.getRandomFloat(0, 1), 1);

				if (ballonSpawned == 20) {
					objects.push(balloonGravityObj.createObject(rootGameWorld,
					   { x: Utility.getRandomInt(0,maxSpawnXPos),
						 y: parent.height,
						 color: "black",
						 pointsAlias: points,
						 dataWorld: rootGameWorld,
						 gameWorld: gameWorld}));
				} else {
					objects.push(balloonNormalObj.createObject(rootGameWorld,
					   { x: Utility.getRandomInt(0,maxSpawnXPos),
						 y: parent.height,
						 color: color1,
						 pointsAlias: points,
						 dataWorld: rootGameWorld,
						 gameWorld: gameWorld}));
				}
				ballonSpawned++
			} else {
				console.log("Koniec etapu")
			}
		}
	}

	WorldObjects.GameWall {
		id: wallUp
		y: -height-balloonBoxHeight
		x: 0
		width: parent.width
		height: 10
		world: gameWorld
		objectName: "wallUp"
	}
	WorldObjects.GameWall {
		id: wallBottom
		y: parent.height * 2 + balloonBoxHeight * 2
		x: 0
		width: parent.width
		height: 10
		world: gameWorld
		objectName: "wallBottom"
	}
	WorldObjects.GameWall {
		id: wallLeft
		y: -balloonBoxHeight
		x: -width
		height: parent.height * 2 + balloonBoxHeight * 2
		width: 10
		world: gameWorld
		objectName: "wallLeft"
	}
	WorldObjects.GameWall {
		id: wallRight
		y: -balloonBoxHeight
		x: parent.width
		height: parent.height * 2 + balloonBoxHeight * 2
		width: 10
		world: gameWorld
		objectName: "wallRight"
	}
}

