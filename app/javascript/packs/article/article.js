$(function(){
    $('.uploadable').inlineattachment({
        uploadUrl: "/articles/attach", // POSTする宛先Url
        uploadFieldName: "image", // ファイルのフィールド名(paramsで取り出す時のkey)
        allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
        extraHeaders: {"X-CSRF-Token": $("meta[name=csrf-token]").attr("content")}
    });
});