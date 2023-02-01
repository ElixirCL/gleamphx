import * as Hooks from "../build/dev/javascript/hooks/video.mjs";

// We need a wrapper to access the current element in gleam
// since phoenix does not pass the element to the hook.
const Video = {
    mounted() { return Hooks.mounted(this.el) },
}

export default Video;