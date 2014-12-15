Function.prototype.myBind = function (context) {
    var fn = this;
    fn.apply(context);
}
