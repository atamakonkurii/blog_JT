window.onload = function() {
    const sample = document.getElementById('youtube').innerHTML;
    const pattern = /(<iframe.*<\/iframe>)/g;
    const result = sample.replace(pattern, '<div class="youtube">$1</div>');
    document.getElementById('youtube').innerHTML = result;
}