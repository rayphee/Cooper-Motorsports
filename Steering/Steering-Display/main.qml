import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: window
    width: 800
    height: 520
    visible: true
    color: "#000000"
    property alias clusterBackground: clusterBackground

    Slider {
        id: slidey
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: 800
        value: 35
        updateValueWhileDragging: true
        minimumValue: 0
        maximumValue: 270
    }

    Rectangle {
        id: clusterBackground
        color: {if (tachometer.arcEnd < 135) Qt.rgba(0, 0, 0, 1); else if (tachometer.arcEnd < 215 && 135 <= tachometer.arcEnd) Qt.rgba((tachometer.arcEnd-135)/80, 0.71, 0.29, 1); else Qt.rgba(1, 0, 0, 1)} //"#000000"
        width: 800
        height: 480

        Behavior on color {
            id: animationArcEnd
            enabled: true
            ColorAnimation {
                duration: 40
                easing.type: Easing.InOutCubic
            }
        }

        TachTorqueIndicator {
            id: tachTorqueIndicator
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ModernGauge {
            id: tachometer
            arcBegin: 0
            arcEnd: slidey.value
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: gearLabel
            color: "#ffffff"
            text: qsTr("GEAR")
            anchors.verticalCenterOffset: 75
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 40
        }

        Text {
            id: gear
            color: "#ffffff"
            text: qsTr("N")
            horizontalAlignment: Text.AlignHCenter
            anchors.verticalCenterOffset: -25
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 140
        }

        Image {
            id: dashMask
            visible: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "DashMask.png"
        }

    }
}
