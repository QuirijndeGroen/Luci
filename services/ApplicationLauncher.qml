pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import "."

Singleton {
    id: root

    // Search filter
    ScriptModel {
        id: filteredApps
        objectProp: "id"
        values: {
            const all = [...DesktopEntries.applications.values];
            const q = searchInput.text.trim().toLowerCase();
            if (q === "") return all.sort((a, b) => a.name.localeCompare(b.name));
            return all.filter(d =>
                (d.name && d.name.toLowerCase().includes(q)) ||
                (d.genericName && d.genericName.toLowerCase().includes(q)) ||
                (d.keywords && d.keywords.some(k => k.toLowerCase().includes(q))) ||
                (d.categories && d.categories.some(c => c.toLowerCase().includes(q)))
            ).sort((a, b) => {
                const an = a.name.toLowerCase();
                const bn = b.name.toLowerCase();
                const aStarts = an.startsWith(q);
                const bStarts = bn.startsWith(q);
                if (aStarts && !bStarts) return -1;
                if (!aStarts && bStarts) return 1;
                return an.localeCompare(bn);
            });
        }
    }
}