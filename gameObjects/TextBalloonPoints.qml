import QtQuick 2.5

import "../scripts/utility.js" as Utility

Text {
	id: textRoot
	property int size: 12
	property string pointsText
	font.pointSize: size
	text: pointsText
	color: "red"
	opacity: 0
	visible: false

	function showPoints() {
		animPointsMove.start()
	}

	ParallelAnimation {
		id: animPointsMove
		onStarted: textRoot.visible = true
		OpacityAnimator {
			target: textRoot
			from: 0
			to: 0.7
			duration: 350
		}
		NumberAnimation {
			property: "x"
			target: textRoot
			from: 0
			to: Utility.getRandomInt(-50, 50)
			duration: 1000
		}
		NumberAnimation {
			property: "y"
			target: textRoot
			from: 0
			to: Utility.getRandomInt(-50, 50)
			duration: 1000
		}
	}
}

