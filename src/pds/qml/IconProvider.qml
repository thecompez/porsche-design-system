pragma Singleton
import QtQuick

QtObject {
    property url baseUrl: ""
    property var manifest: ({})

    function resolve(name) {
        const fileName = manifest && manifest[name] ? manifest[name] : ""
        if (!fileName || baseUrl.toString().length === 0)
            return ""
        const root = baseUrl.toString()
        return root.endsWith("/") ? root + fileName : root + "/" + fileName
    }
}
