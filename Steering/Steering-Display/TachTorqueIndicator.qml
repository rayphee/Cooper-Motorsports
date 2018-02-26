import QtQuick 2.0

Item {
    id: tachTorqueIndicator
    width: 280
    height: 280

    property real arcBegin: 0
    property real arcEnd: 270
    property real arcOffset: 180
    property bool showBackground: true
    property real lineWidth: 15
    property string colorCircle: "#F2F2F2"
    property string colorBackground: "#262626"

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90 + parent.arcOffset

        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var torqueStart = Math.PI * (135 / 180)
            var powerStart = Math.PI * (215 / 180)
            var rpmEnd = Math.PI * (270 / 180)
            var torqueGradient = ctx.createLinearGradient(0, 0, 250, 250);

            torqueGradient.addColorStop(1, Qt.rgba(0, 0.71, 0.29, 1));
            torqueGradient.addColorStop(0, Qt.rgba(1, 0.71, 0.29, 1));
            ctx.reset()
            ctx.beginPath()
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
            ctx.lineWidth = tachTorqueIndicator.lineWidth
            ctx.strokeStyle = "#262626"
            ctx.stroke()
            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, torqueStart, false)
            ctx.lineWidth = tachTorqueIndicator.lineWidth
            ctx.strokeStyle = "#F2F2F2"
            ctx.stroke()
            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, torqueStart, powerStart, false)
            ctx.lineWidth = tachTorqueIndicator.lineWidth
            ctx.strokeStyle = torqueGradient
            ctx.stroke()
            ctx.beginPath();
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, powerStart, rpmEnd, false)
            ctx.lineWidth = tachTorqueIndicator.lineWidth
            ctx.strokeStyle = "#FF0000"
            ctx.stroke()
        }
    }
}
