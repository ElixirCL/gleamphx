import ffi.{DOMElement}

pub fn mounted(el: DOMElement) {
  ffi.get_user_media()
  |> ffi.stream(el)
}
