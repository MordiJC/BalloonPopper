import QtQuick 2.0
import Box2D 2.0

import "../balloons" as Balloons

import "../scripts/utility.js" as Utility

/**
 * GameWorld.qml - Plik zawiera "Świat Gry", który zawiera
 * wszystkie elementy rozgrywki.
 */

Item {
	id: rootGameWorld
	anchors.fill: parent

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
	property int minSpawnTime: 100
	// Maksymnalny iterwał tworzenia nowych balonów.
	property int maxSpawnTime: 800

	/**
	 * Obiekt świata fizycznego, w którym będą przeprowadzane obliczenia.
	 */
    World {
        id: gameWorld
		gravity: Qt.point(0, 1)
    }

	/**
	 * Timer przeznaczony do dodawania nowych balonów do obszaru gry
	 * co określony zakres czasu.
	 */
	Timer {
		id: balloonSpawnTimer
		running: false
		interval: Utility.getRandomInt(minSpawnTime, maxSpawnTime);
		onTriggered: {
			interval = Utility.getRandomInt(minSpawnTime, maxSpawnTime);

			objects.push(Balloons.createObject(rootGameWorld, {world: gameWorld}));
		}
	}

	Balloons.Balloon {
		id: balloon
        x: 100
        y: 100
        gameWorld: gameWorld
	}
}

