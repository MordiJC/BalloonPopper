import QtQuick 2.0

Item {
	id: gameArea
	// Anchory ustawiamy przy tworzeniu obiektu na zewnątrz
	// anchors.fill: parent

	// Typ tła
	property alias bgtype: background.state

	/* Wartosć podawana do wybranego obiektu tła:
	 * "color": ("white", "#3E3", itp.)
	 * "image": (url do obrazka)
	 * "none": Nie ma znaczenia, tło nie będzie wyświetlone.
	 */
	property string bgvalue: "white"

	// Zmienna przechowujaca referencję do obiekty zawierającego scenę gry.
	property var scene: undefined

	onSceneChanged: {
		sceneItem.children[0] = scene;
	}

	Item {
		id: background
		anchors.fill: parent
		z: -1
		state: "none"

		Rectangle {
			id: colorBackground
			anchors.fill: parent
			color: bgvalue
			visible: false
		}

		Image {
			id: imageBackground
			anchors.fill: parent
			source: bgvalue
			visible: false
		}

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
		]
	} // End of Item:background

	Item {
		id: sceneItem
		anchors.fill: parent
	}
}
