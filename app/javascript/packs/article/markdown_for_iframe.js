window.onload = function() {
    const sample_google_map = document.getElementById('markdown_iframe').innerHTML;
    const pattern_google_map = /(<iframe.*google.*<\/iframe>)/g;
    const result_google_map = sample_google_map.replace(pattern_google_map, '<div class="google_map">$1</div>');
    document.getElementById('markdown_iframe').innerHTML = result_google_map;

    const sample_youtube = document.getElementById('markdown_iframe').innerHTML;
    const pattern_youtube = /(<iframe.*youtube.*<\/iframe>)/g;
    const result_youtube = sample_youtube.replace(pattern_youtube, '<div class="youtube">$1</div>');
    document.getElementById('markdown_iframe').innerHTML = result_youtube;
}