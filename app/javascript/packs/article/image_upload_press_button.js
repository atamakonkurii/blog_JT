window.onload = function(){
    document.getElementById("place").onclick=function(){
        let area = document.getElementById('text-editor');
        let text = "# ";
        //カーソルの位置を基準に前後を分割して、その間に文字列を挿入
        area.value = area.value.substr(0, area.selectionStart)
            + text
            + area.value.substr(area.selectionStart);
    }

    document.getElementById("face").onclick=function(){
        let area = document.getElementById('text-editor');
        let text = "## ";
        //カーソルの位置を基準に前後を分割して、その間に文字列を挿入
        area.value = area.value.substr(0, area.selectionStart)
            + text
            + area.value.substr(area.selectionStart);
    }

    document.getElementById("image-up").onclick=function(){
        let area = document.getElementById('text-editor');
        let text = "### ";
        //カーソルの位置を基準に前後を分割して、その間に文字列を挿入
        area.value = area.value.substr(0, area.selectionStart)
            + text
            + area.value.substr(area.selectionStart);
    }
}