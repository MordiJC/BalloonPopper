import QtQuick 2.0
import Box2D 2.0

import "../balloons" as Balloons
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

	/**
	 * Zmienna używana do ustalenia położenia górnej ściany wykrywającej,
	 * czy balon wyleciał poza obszar widoczny dla gracza.
	 */
	property real balloonHeight: 32

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

	// Minimalny interwał tworzenia nowych balonów.
	property int minSpawnTime: 200
	// Maksymnalny iterwał tworzenia nowych balonów.
	property int maxSpawnTime: 1000

	// Maksymalnny x dla tworzenia nowych balonów.
	property int maxSpawnXPos: parent.width - 50

	// Sygnał informujący o uzyskaniu punktów.
	signal pointsReceieved(int points)

	// Sygnał informujacy o uzyskaniu bonusu.
	signal bonusReceieved(string bonusName)

	/**
	 * Obiekt świata fizycznego, w którym będą przeprowadzane obliczenia.
	 */
    World {
        id: gameWorld
		gravity: Qt.point(0, -5)
		Component.onCompleted: balloonSpawnTimer.start()
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
			interval = Utility.getRandomInt(minSpawnTime, maxSpawnTime);

			var color1 = Qt.rgba(Utility.getRandomFloat(0, 1), Utility.getRandomFloat(0, 0.5), Utility.getRandomFloat(0, 1), 1)
			objects.push(balloonsComponent.createObject(rootGameWorld,
				{ x: Utility.getRandomInt(0,maxSpawnXPos), y: parent.height-100, color: color1, gameWorld: gameWorld}))
		}
	}

	WorldObjects.Balloon {
		id: balloon
        x: 100
        y: 100
        gameWorld: gameWorld
	}

	WorldObjects.GameWall {
		id: wallBottom
		y: parent.height
		x: 0
		width: parent.width
		gameWorld: gameWorld
	}
	WorldObjects.GameWall {
		id: wallUp
		y: -height
		x: 0
		color: "transparent"
		width: parent.width
		gameWorld: gameWorld
	}
	WorldObjects.GameWall {
		id: wallLeft
		y: 0
		x: -width
		width: parent.width/2
		height: parent.height * 2
		gameWorld: gameWorld
	}
	WorldObjects.GameWall {
		id: wallRight
		y: 0
		x: parent.width
		width: parent.width/2
		height: parent.height * 2
		gameWorld: gameWorld
	}
}

