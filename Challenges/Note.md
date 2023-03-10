#  SwiftUI

Form : for user input
- Picker
- TextField
- Segment

TableView
-> List : working with tables of data, and strings
-> Section
-> ForEach
-> Group

UINavigationController
UINavigationBar
-> NavigationStack
-> NavigationLink

UILabel
-> Text

UIImageView
-> Image

UITabViewController
-> TabView

UIStackView
-> HStack
-> VStack
-> ZStack


------------------------------------------------------------------------

@StateObject: keeps object alive throughout the life of app.
@EnvironmentObject: share data accross many places.

@State: allows struct to modify data, normally marked as private for local usage with value of type String and Int.
$: two ways binding.

ObservableObject Protocol: allows instance of class to send notification when its state changes. 
@Publish: placed before class properties. Use to trigger the notification to consumer when its value changes.

UIHostingViewController: bridge between UIKit and SwiftUI.
TupleView: the return type of @ViewBuilder

Conditional modifier: tenary operator
Envioroment modifier: child view can modify the parent modifier (Eg., font()) != Regular modifier (Eg., blur())
Views as properties: hanlde complex view hierachies. (recommended appraoch is @ViewBuilder)
View Composition
Custom modifier
Custom container

------------------------------------------------------------------------

Stepper
DatePicker
Create ML: framework which trains machine learning models from CSV files.
Core ML: Apple has said predictions might fail, perhaps if we provide invalid input.

------------------------------------------------------------------------

Bundle: allows the system to store all the files for a single app in one place - the binary code (the actual compiled Swift stuff we wrote). Multiple bundles in a single app, allowing you to write things like Siri extensions, iMessage apps, widgets, and more, all inside a single iOS app bundle. 
UITextChecker: uses the built-in system dictionary.
onSubmit(): presses return on the keyboard

------------------------------------------------------------------------

scaleEffect
blur
animation
transition
