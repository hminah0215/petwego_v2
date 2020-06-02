(document.querySelector(".sweet-wrong").onclick = function () {
    sweetAlert("Oops...", "Something went wrong !!", "error");
}),
    (document.querySelector(".sweet-message").onclick = function () {
        swal("Hey, Here's a message !!");
    }),
    (document.querySelector(".sweet-text").onclick = function () {
        swal("Hey, Here's a message !!", "It's pretty, isn't it?");
    }),
    (document.querySelector(".sweet-success").onclick = function () {
        swal("Hey, Good job !!", "You clicked the button !!", "success");
    }),
    (document.querySelector(".sweet-confirm").onclick = function () {
        swal(
            {
                title: "댓글을 등록하시겠습니까 ?",
                text: "건강한 댓글 문화를 위해, 한번 등록한 댓글은 수정할 수 없습니다!",
                type: "warning",
                showCancelButton: !0,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "댓글 등록 하겠음!!",
                closeOnConfirm: !1,
            },
            function () {
                swal("등록완료 !!", "댓글을 등록하였습니다 :>", "success");
            }
        );
    }),
    (document.querySelector(".sweet-success-cancel").onclick = function () {
        swal(
            {
                title: "Are you sure to delete ?",
                text: "You will not be able to recover this imaginary file !!",
                type: "warning",
                showCancelButton: !0,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes, delete it !!",
                cancelButtonText: "No, cancel it !!",
                closeOnConfirm: !1,
                closeOnCancel: !1,
            },
            function (e) {
                e ? swal("Deleted !!", "Hey, your imaginary file has been deleted !!", "success") : swal("Cancelled !!", "Hey, your imaginary file is safe !!", "error");
            }
        );
    }),
    (document.querySelector(".sweet-image-message").onclick = function () {
        swal({ title: "Sweet !!", text: "Hey, Here's a custom image !!", imageUrl: "../assets/images/hand.jpg" });
    }),
    (document.querySelector(".sweet-html").onclick = function () {
        swal({ title: "Sweet !!", text: "<span style='color:#ff0000'>Hey, you are using HTML !!<span>", html: !0 });
    }),
    (document.querySelector(".sweet-auto").onclick = function () {
        swal({ title: "Sweet auto close alert !!", text: "Hey, i will close in 2 seconds !!", timer: 2e3, showConfirmButton: !1 });
    }),
    (document.querySelector(".sweet-prompt").onclick = function () {
        swal({ title: "Enter an input !!", text: "Write something interesting !!", type: "input", showCancelButton: !0, closeOnConfirm: !1, animation: "slide-from-top", inputPlaceholder: "Write something" }, function (e) {
            return !1 !== e && ("" === e ? (swal.showInputError("You need to write something!"), !1) : void swal("Hey !!", "You wrote: " + e, "success"));
        });
    }),
    (document.querySelector(".sweet-ajax").onclick = function () {
        swal({ title: "Sweet ajax request !!", text: "Submit to run ajax request !!", type: "info", showCancelButton: !0, closeOnConfirm: !1, showLoaderOnConfirm: !0 }, function () {
            setTimeout(function () {
                swal("Hey, your ajax request finished !!");
            }, 2e3);
        });
    });
