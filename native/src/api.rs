// This is the entry point of your Rust library.
// When adding new code to your project, note that only items used
// here will be transformed to their Dart equivalents.

// A plain enum without any fields. This is similar to Dart- or C-style enums.
// flutter_rust_bridge is capable of generating code for enums with fields
// (@freezed classes in Dart and tagged unions in C).

/// Represents the current rutime platform.
pub enum Platform {
	/// Current runtime environment is Android
	/// (or ChromeOS, FireOS, etc.)
	Android,
	/// Current runtime environment is iOS
	/// (or iPadOS, watchOS, tvOS)
	Ios,
	/// Current runtime environment is Windows
	/// (including UWP)
	Windows,
	/// Current runtime environment is Unix
	/// (Linux, BSD, MacOS, etc.)
	Unix,
	/// Current runtime environment is MacOS
	Macos,
	/// Current runtime environment is WebAssembly
	/// (or any other Wasm-based environment)
	Wasm,
	/// Current runtime environment could not be determined
	/// (or is not supported)
	Unknown,
}

// A function definition in Rust. Similar to Dart, the return type must always be named
// and is never inferred.
/// Returns the current platform
///
/// # Returns
///
/// [Platform] enum representing the current runtime environment.
pub fn platform() -> Platform {
	// This is a macro, a special expression that expands into code. In Rust, all macros
	// end with an exclamation mark and can be invoked with all kinds of brackets (parentheses,
	// brackets and curly braces). However, certain conventions exist, for example the
	// vector macro is almost always invoked as vec![..].
	//
	// The cfg!() macro returns a boolean value based on the current compiler configuration.
	// When attached to expressions (#[cfg(..)] form), they show or hide the expression at compile time.
	// Here, however, they evaluate to runtime values, which may or may not be optimized out
	// by the compiler. A variety of configurations are demonstrated here which cover most of
	// the modern oeprating systems. Try running the Flutter application on different machines
	// and see if it matches your expected OS.
	//
	// Furthermore, in Rust, the last expression in a function is the return value and does
	// not have the trailing semicolon. This entire if-else chain forms a single expression.
	if cfg!(windows) {
		Platform::Windows
	} else if cfg!(target_os = "android") {
		Platform::Android
	} else if cfg!(target_os = "ios") {
		Platform::Ios
	} else if cfg!(target_os = "macos") {
		Platform::Macos
	} else if cfg!(target_family = "wasm") {
		Platform::Wasm
	} else if cfg!(unix) {
		Platform::Unix
	} else {
		Platform::Unknown
	}
}

// The convention for Rust identifiers is the snake_case,
// and they are automatically converted to camelCase on the Dart side.

/// Returns whether the current runtime is in debug mode or not
///
/// # Returns
///
/// `true` if the current runtime is in debug mode, `false` otherwise.
pub fn rust_release_mode() -> bool {
	cfg!(not(debug_assertions))
}

/// Adds two integers
pub fn add(a: i32, b: i32) -> i32 {
	a.wrapping_add(b)
}

/// Divides two integers
pub fn divide(a: i32, b: i32) -> i32 {
	a.wrapping_div(b)
}