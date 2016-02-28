import QtQuick 2.0

/**
 * GameArea.qml - Plik zawierający główny obszar gry.
 */

Item {
	id: gameArea

	// Typ tła
	property alias bgtype: background.state

	/* Wartosć podawana do wybranego obiektu tła:
	 * "color" - ("white", "#3E3", itp.)
	 * "image" - (url do obrazka)
	 * "none"  - Nie ma znaczenia, tło nie będzie wyświetlone.
	 */
	property string bgvalue: "white"

	// Zmienna przechowujaca referencję do obiekty zawierającego scenę gry.
	property var scene: undefined

	/**
	 * Ustawiamy `clip` na `true`, ponieważ nie chcemy,
	 * aby obiekty podrzędne wychodziły poza obszar rysowania.
	 */
	clip: true

	/**
	 * Jeżeli wartość zmiennej `scene` ulegnie zmianie, to przypisujemy
	 * ją jako pierwsze dziecko objektu `sceneItem`. W ten sposób mamy
	 * tylko jeden obiekt główny, będący objektem obszaru rysowania gry.
	 */
	onSceneChanged: {
		sceneItem.children[0] = scene;
	}

	/**
	 * Kontener z tłem obszaru gry. Aktualnie może przyjmować 3 stany:
	 * "none"  - brak tła.
	 * "color" - tłem klor określony zmienną główną `bgvalue`
	 * "image" - tłem będzie obraz wskazywany przez url ze zmiennej `bgvalue`
	 */
	Item {
		id: background
		anchors.fill: parent
		z: -1 // Ustawiając tą zmienną na -1 mamy pewność, że tło nie będzie nachodziło na obszar rysowania gry.
		state: "none"

		/**
		 * Prostokąt wypełniający cały obszar gry i będący jednocześnie
		 * tłem o wybranym kolorze.
		 */
		Rectangle {
			id: colorBackground
			anchors.fill: parent
			color: bgvalue
			visible: false
		}

		/**
		 * Obraz będący tłem obszaru gry. Jego zawartość jest określana
		 * url'em ze zmiennej `bgvalue`.
		 */
		Image {
			id: imageBackground
			anchors.fill: parent
			source: bgvalue
			visible: false
		}

		/**
		 * Lista stanów tła. Kazdy stan opisuje inny układ tła.
		 * Stan jest wybierany poprzez ustawienie odpowiedniej wartości
		 * zmiennej `bgtype`.
		 */
		states: [
			State {
				name: "color"
				PropertyChanges {
					target: colorBackground
					visible: true
				}
				PropertyChanges {
					target: imageBackground
					visible: false
				}
			},
			State {
				name: "image"
				PropertyChanges {
					target: colorBackground
					visible: false
				}
				PropertyChanges {
					target: imageBackground
					visible: true
				}
			},
			State {
				name: "none"
				PropertyChanges {
					target: colorBackground
					visible: false
				}
				PropertyChanges {
					target: imageBackground
					visible: false
				}
			}
		] // states
	} // Item: background

	/**
	 * Kontener przeznaczony na obszar rysowania gry. Jego zawartość
	 * ustawiamy poprzez podanie jej do zmiennej `scene`.
	 */
	Item {
		id: sceneItem
		anchors.fill: parent
	}
} // Item: gameArea
