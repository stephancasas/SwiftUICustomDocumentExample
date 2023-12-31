# SwiftUICustomDocumentExample

This repository provides example code demonstrating the implementation of a custom document type with a custom Uniform Type Identifier (`UTType`) in a modern macOS application which is not backed by CoreData. It is a reference for myself and others.

If you attempt to replicate the behavior of this application in your own code, pay close attention to the settings given in the `Info.plist` example. These values are derived from settings which are automatically generated by the build target editor's *Info* tab under the *Document Types* and *Exported Type Identifiers* disclosure triangles.

## Build Target Editors

As of Xcode 13, the editors for these items are broken in that they don't draw some of the UI elements on screen which are required to edit the outline views vis-a-vis adding/removing items. However, I still recommend that you use these editors, because if they become out-of-sync with the content of your project's real `Info.plist`, restoring their parity is an annoying process.

Unless, at the time of reading this, Apple has fixed the bug in Xcode affecting the outline views, to add an item in these views, click in the empty region to the left of the outline view. This will trigger an *Add Row* operation and you will be able to include additional detail about your document type or uniform type identifier.

If this does not work, open the Accessibility Inspector, activate the target selector, target the outline view, and then perform the *Show Menu* action to display the context menu for that outline view. This menu will provide the appropriate exposures for adding and removing items.

## License

MIT
