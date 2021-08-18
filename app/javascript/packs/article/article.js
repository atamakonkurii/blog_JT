$(function(){
    $('.uploadable').inlineattachment({
        uploadUrl: "/articles/attach", // POSTする宛先Url
        uploadFieldName: "image", // ファイルのフィールド名(paramsで取り出す時のkey)
        allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
        extraHeaders: {"X-CSRF-Token": $("meta[name=csrf-token]").attr("content")}
    });
});


// $(document).ready(function() {
//     $('.uploadable').on('drop', function(e) { //dropのイベントをハンドル
//         e.preventDefault(); //元の動きを止める処理
//         f = e.originalEvent.dataTransfer.files[0]; //ドロップされた画像の1件目を取得
//         var formData = new FormData();
//         formData.append('image', f); // FormDataに画像を追加
//
//         // ajaxで画像をアップロード
//         $.ajax({
//             url  : "/articles/attach",
//             type : "POST",
//             data : formData,
//             dataType    : "json",
//             contentType: false,
//             processData: false
//         })
//             .done(function(data, textStatus, jqXHR){
//                 setImage(data['name'], data['url'])
//             })
//             .fail(function(jqXHR, textStatus, errorThrown){
//                 alert("fail");
//             });
//     });
//
//     // テキストエリアに画像タグを追加する関数
//     function setImage(name, url) {
//         var textarea = document.querySelector('textarea');
//         var sentence = textarea.value;
//         var len      = sentence.length;
//         var pos      = textarea.selectionStart;
//         var before   = sentence.substr(0, pos);
//         var word     = '![' + name + '](' + url + ')';
//         var after    = sentence.substr(pos, len);
//
//         sentence = before + word + after;
//
//         textarea.value = sentence;
//     }
// });