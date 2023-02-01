
export const getUserMedia = () => navigator.mediaDevices.getUserMedia({audio: true, video: true});
export const stream = async (stream, el) => {
    const video = document.createElement('video');
    video.srcObject = await stream;
    el.appendChild(video);
    video.play();
    return video;
};