clawhammer
==========

Clawhammer is an awesome style of banjo playing.

Also, it is now a library for iOS that allows for live tweaking of values within an app.

Tweakable values, or 'Tweaks' are identified by name and can one of several types:

 - String
 - Font
 - Number (integer, float, or double)
 - Color
 
Depending on the type of the tweak, other values (like a valid numerical range in the case of the Number type) can be specified.

Information about what tweaks are available is provided to Clawhammer via a JSON spec file that is expected to be in the app's bundle. Clawhammer provides an interface for editing the values of these tweaks. It's up to the app developer to present this interface at runtime.

Via a category on NSObject, objects can be registered to respond to a particular Tweak. For example, an instance of UILabel can be made to keep its font property synchronized with the value of a font tweak called "labelFont"

This library is under heavy development and doesn't really totally 100% always without exception completely work so hang on a minute while I build it out.

Charlie
