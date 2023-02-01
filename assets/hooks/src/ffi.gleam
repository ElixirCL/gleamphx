import gleam/javascript/promise.{Promise}

/// Represents a [MediaStream](https://developer.mozilla.org/en-US/docs/Web/API/MediaStream).
pub external type MediaStream

/// Represents a DOM [Element](https://developer.mozilla.org/en-US/docs/Web/API/Element).
pub external type DOMElement

pub external fn get_user_media() -> Promise(MediaStream) =
  "./ffi_bindings.js" "getUserMedia"

pub external fn stream(Promise(MediaStream), DOMElement) -> Promise(DOMElement) =
  "./ffi_bindings.js" "stream"
