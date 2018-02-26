import QtQuick 2.0

Item {
    id: modernGauge
    width: 460
    height: 460

    property real arcBegin: 0
    property real arcEnd: 270
    property real arcOffset: 180
    property bool isPie: false
    property bool showBackground: true
    property real lineWidth: 30
    property string colorCircle: "#F2F2F2"
    property string colorBackground: "#262626"

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 20

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()

    Behavior on arcBegin {
       id: animationArcBegin
       enabled: true
       NumberAnimation {
           duration: modernGauge.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Behavior on arcEnd {
       id: animationArcEnd
       enabled: true
       NumberAnimation {
           duration: modernGauge.animationDuration
           easing.type: Easing.InOutCubic
       }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90 + parent.arcOffset

        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

            if (modernGauge.isPie) {
                if (modernGauge.showBackground) {
                    ctx.beginPath()
                    ctx.fillStyle = modernGauge.colorBackground
                    ctx.moveTo(x, y)
                    ctx.arc(x, y, width / 2, 0, Math.PI * 2, false)
                    ctx.lineTo(x, y)
                    ctx.fill()
                }
                ctx.beginPath()
                ctx.fillStyle = modernGauge.colorCircle
                ctx.moveTo(x, y)
                ctx.arc(x, y, width / 2, start, end, false)
                ctx.lineTo(x, y)
                ctx.fill()
            } else {
                if (modernGauge.showBackground) {
                    ctx.beginPath()
                    ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                    ctx.lineWidth = modernGauge.lineWidth
                    ctx.strokeStyle = modernGauge.colorBackground
                    ctx.stroke()
                }
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
                ctx.lineWidth = modernGauge.lineWidth
                ctx.strokeStyle = modernGauge.colorCircle
                ctx.stroke()
            }
        }
    }

    Image {
        id: tachMask
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "TachMask.png"

        Image {
            id: numberMask
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "TachNumberMask.png"
        }
    }
}
