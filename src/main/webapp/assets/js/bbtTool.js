/**
 * Created by meng on 2015/6/26.
 */
/*
 * Format amount from pure number to money format.
 * e.g. 1234567 -> 1,234,567
 */
function formatAmount(s, n, unit) {
    n = n > 0 && n <= 20 ? n : 0;
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
    var l = s.split(".")[0].split("").reverse();
    var r = s.split(".").length>1?s.split(".")[1]:'';
    var t = "";
    for (i = 0; i < l.length; i++) {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    if (n > 0) {
        if (unit != null) {
            return unit + t.split("").reverse().join("") + "." + r; // 99.99
        }
        return t.split("").reverse().join("") + "." + r; // 99.99
    }
    else {
        if (unit != null) {
            return unit + t.split("").reverse().join("") + "." + r; // 99.99
        }
        return t.split("").reverse().join("");
    }
}
/*
 * Translate amount to Chinese.
 * e.g. 1234567 -> 壹佰贰拾叁万肆仟伍佰陆拾柒
 */
function toChinese(n) {
    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
        return "数据非法";
    var unit = "千百拾亿千百拾万千百拾元角分", str = "";
    n += "00";
    var p = n.indexOf('.');
    if (p >= 0) {
        n = n.substring(0, p) + n.substr(p + 1, 2);
    }
    unit = unit.substr(unit.length - n.length);
    for (var i = 0; i < n.length; i++) {
        str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
    }
    return str.replace(/零(千|百|拾|角)/g, "零")
        .replace(/(零)+/g, "零")
        .replace(/零(万|亿|元)/g, "$1")
        .replace(/(亿)万|壹(拾)/g, "$1$2")
        .replace(/^元零?|零分/g, "")
        .replace(/元$/g, "元")
        .replace('分', '');
}
/*
 * Compute time from the date past in till now.
 * @param {int} milliseconds of the start date
 * @returns {String} formatted time
 */
function timeTillNow(ms) {
    var date = new Date(parseInt(ms));
    var now = new Date();
    var gap = (now.valueOf() - date.valueOf()) / 1000;
    var day = parseInt(gap / 60 / 60 / 24);
    if (day > 0)
        return day + "天前";
    else {
        var hours = parseInt(gap / 60 / 60);
        if (hours > 0)
            return hours + "小时前";
        else {
            var mins = parseInt(gap / 60);
            if (mins > 0)
                return mins + "分钟前";
            else {
                return "刚刚";
            }
        }
    }
}
/**
 * add ajax loading to <a data-toggle="modal" href="path/to/ajax"...></a>
 */
function addClickHandler() {
    $("a[data-toggle=modal]").click(function() {
        var target = $(this).attr('data-target');
        var url = $(this).attr('href');
        $(target).load(url, function() {
            //$("input, select, textarea").not("[type=submit]").jqBootstrapValidation();
        });
    });
}
/**
 * add confirm function to <a confirm="confirm something"...></a>
 */
function addConfirmFunc() {
    $('a[confirm]').on('click', function(evt) {
        if (!confirm($(this).attr('confirm'))) {
            return false;
        } else {
            return true;
        }
    });
}

/**
 * Format loan duration
 * @param {string} duration
 * @returns {*年零*个月零*天}
 */
function formatDuration(duration) {
    return duration.replace('零0个月零', '零').replace('0年零', '').replace('零0天', '');
}

function formatTime(time) {
    if (time == null || isNaN(time)) return null;
    var date = new Date(time);
    return date.toLocaleDateString();
}

// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
// 例子：
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
Date.prototype.Format = function(fmt)
{
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds()             //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

$(function() {
    /**
     * binding events.
     */
    addClickHandler();
    addConfirmFunc();

    $(".super-loading").hide();
});

function apply(thisArg, argArray) {
}
/**
 * 获取Url的参数值
 *
 * @method getURLParameter
 * @param {String} name 参数名
 * @param {String} win window对象
 */
function getURLParameter(name, win) {
    if(!win)
        return decodeURI(
            (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search) || ['', ''])[1]
        );
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(win.location.search) || ['', ''])[1]
    );
}

function showCCAlert(msg, status) {
    if (status) {
        $('.btn-danger').click();
        $('.modal-danger .modal-body').html(msg);
        $("#modal-danger").addClass('in');
        $("#modal-danger").show().attr('aria-hidden','false');

    } else {
        $('#modal-danger').show();
        $('#modal-danger .modal-body').html(msg);

    }
}
function showCCconfirm(msg, okFunction, cancelFunction) {

    $('.cc-confirm .cc-alert-message').text(msg);
    $('.cc-confirm').show();
    $('.cc-confirm-ok-btn').on('click',function(){
        okFunction();

    });
    $('.cc-confirm-cancel-btn').on('click',function(){
        cancelFunction();
    })
}
function hideCCAlert() {
    $('.cc-alert-bg').hide();
}
function hideCCconfirm() {
    $('.cc-confirm').hide();
}




(function(e, c) {
    var d = "multiple" in document.createElement("INPUT");
    var j = "FileList" in window;
    var b = "FileReader" in window;
    var f = function(l, m) {
        var k = this;
        this.settings = e.extend({}, e.fn.ace_file_input.defaults, m);
        this.$element = e(l);
        this.element = l;
        this.disabled = false;
        this.can_reset = true;
        this.$element.on("change.ace_inner_call", function(o, n) {
            if (n === true) {
                return
            }
            return a.call(k)
        });
        this.$element.wrap('<div class="ace-file-input" />');
        this.apply_settings()
    };
    f.error = {FILE_LOAD_FAILED: 1,IMAGE_LOAD_FAILED: 2,THUMBNAIL_FAILED: 3};
    f.prototype.apply_settings = function() {
        var l = this;
        var k = !!this.settings.icon_remove;
        this.multi = this.$element.attr("multiple") && d;
        this.well_style = this.settings.style == "well";
        if (this.well_style) {
            this.$element.parent().addClass("ace-file-multiple")
        } else {
            this.$element.parent().removeClass("ace-file-multiple")
        }
        this.$element.parent().find(":not(input[type=file])").remove();
        this.$element.after('<label data-title="' + this.settings.btn_choose + '"><span data-title="' + this.settings.no_file + '">' + (this.settings.no_icon ? '<i class="' + this.settings.no_icon + '"></i>' : "") + "</span></label>" + (k ? '<a class="remove" href="#"><i class="' + this.settings.icon_remove + '"></i></a>' : ""));
        this.$label = this.$element.next();
        this.$label.on("click", function() {
            if (!this.disabled && !l.element.disabled && !l.$element.attr("readonly")) {
                l.$element.click()
            }
        });
        if (k) {
            this.$label.next("a").on(ace.click_event, function() {
                if (!l.can_reset) {
                    return false
                }
                var m = true;
                if (l.settings.before_remove) {
                    m = l.settings.before_remove.call(l.element)
                }
                if (!m) {
                    return false
                }
                return l.reset_input()
            })
        }
        if (this.settings.droppable && j) {
            g.call(this)
        }
    };
    f.prototype.show_file_list = function(k) {
        var n = typeof k === "undefined" ? this.$element.data("ace_input_files") : k;
        if (!n || n.length == 0) {
            return
        }
        if (this.well_style) {
            this.$label.find("span").remove();
            if (!this.settings.btn_change) {
                this.$label.addClass("hide-placeholder")
            }
        }
        this.$label.attr("data-title", this.settings.btn_change).addClass("selected");
        for (var p = 0; p < n.length; p++) {
            var l = typeof n[p] === "string" ? n[p] : e.trim(n[p].name);
            var q = l.lastIndexOf("\\") + 1;
            if (q == 0) {
                q = l.lastIndexOf("/") + 1
            }
            l = l.substr(q);
            var m = "fa fa-file";
            if ((/\.(jpe?g|png|gif|svg|bmp|tiff?)$/i).test(l)) {
                m = "fa fa-picture-o"
            } else {
                if ((/\.(mpe?g|flv|mov|avi|swf|mp4|mkv|webm|wmv|3gp)$/i).test(l)) {
                    m = "fa fa-film"
                } else {
                    if ((/\.(mp3|ogg|wav|wma|amr|aac)$/i).test(l)) {
                        m = "fa fa-music"
                    }
                }
            }
            if (!this.well_style) {
                this.$label.find("span").attr({"data-title": l}).find('[class*="icon-"]').attr("class", m)
            } else {
                this.$label.append('<span data-title="' + l + '"><i class="' + m + '"></i></span>');
                var r = e.trim(n[p].type);
                var o = b && this.settings.thumbnail && ((r.length > 0 && r.match("image")) || (r.length == 0 && m == "icon-picture"));
                if (o) {
                    var s = this;
                    e.when(i.call(this, n[p])).fail(function(t) {
                        if (s.settings.preview_error) {
                            s.settings.preview_error.call(s, l, t.code)
                        }
                    })
                }
            }
        }
        return true
    };
    f.prototype.reset_input = function() {
        this.$label.attr({"data-title": this.settings.btn_choose,"class": ""}).find("span:first").attr({"data-title": this.settings.no_file,"class": ""}).find('[class*="icon-"]').attr("class", this.settings.no_icon).prev("img").remove();
        if (!this.settings.no_icon) {
            this.$label.find('[class*="icon-"]').remove()
        }
        this.$label.find("span").not(":first").remove();
        if (this.$element.data("ace_input_files")) {
            this.$element.removeData("ace_input_files");
            this.$element.removeData("ace_input_method")
        }
        this.reset_input_field();
        return false
    };
    f.prototype.reset_input_field = function() {
        this.$element.wrap("<form>").closest("form").get(0).reset();
        this.$element.unwrap()
    };
    f.prototype.enable_reset = function(k) {
        this.can_reset = k
    };
    f.prototype.disable = function() {
        this.disabled = true;
        this.$element.attr("disabled", "disabled").addClass("disabled")
    };
    f.prototype.enable = function() {
        this.disabled = false;
        this.$element.removeAttr("disabled").removeClass("disabled")
    };
    f.prototype.files = function() {
        return e(this).data("ace_input_files") || null
    };
    f.prototype.method = function() {
        return e(this).data("ace_input_method") || ""
    };
    f.prototype.update_settings = function(k) {
        this.settings = e.extend({}, this.settings, k);
        this.apply_settings()
    };
    var g = function() {
        var l = this;
        var k = this.element.parentNode;
        e(k).on("dragenter", function(m) {
            m.preventDefault();
            m.stopPropagation()
        }).on("dragover", function(m) {
            m.preventDefault();
            m.stopPropagation()
        }).on("drop", function(q) {
            q.preventDefault();
            q.stopPropagation();
            var p = q.originalEvent.dataTransfer;
            var o = p.files;
            if (!l.multi && o.length > 1) {
                var n = [];
                n.push(o[0]);
                o = n
            }
            var m = true;
            if (l.settings.before_change) {
                m = l.settings.before_change.call(l.element, o, true)
            }
            if (!m || m.length == 0) {
                return false
            }
            if (m instanceof Array || (j && m instanceof FileList)) {
                o = m
            }
            l.$element.data("ace_input_files", o);
            l.$element.data("ace_input_method", "drop");
            l.show_file_list(o);
            l.$element.triggerHandler("change", [true]);
            return true
        })
    };
    var a = function() {
        var l = true;
        if (this.settings.before_change) {
            l = this.settings.before_change.call(this.element, this.element.files || [this.element.value], false)
        }
        if (!l || l.length == 0) {
            if (!this.$element.data("ace_input_files")) {
                this.reset_input_field()
            }
            return false
        }
        var m = !j ? null : ((l instanceof Array || l instanceof FileList) ? l : this.element.files);
        this.$element.data("ace_input_method", "select");
        if (m && m.length > 0) {
            this.$element.data("ace_input_files", m)
        } else {
            var k = e.trim(this.element.value);
            if (k && k.length > 0) {
                m = [];
                m.push(k);
                this.$element.data("ace_input_files", m)
            }
        }
        if (!m || m.length == 0) {
            return false
        }
        this.show_file_list(m);
        return true
    };
    var i = function(o) {
        var n = this;
        var l = n.$label.find("span:last");
        var m = new e.Deferred;
        var k = new FileReader();
        k.onload = function(q) {
            l.prepend("<img class='middle' style='display:none;' />");
            var p = l.find("img:last").get(0);
            e(p).one("load", function() {
                var t = 50;
                if (n.settings.thumbnail == "large") {
                    t = 150
                } else {
                    if (n.settings.thumbnail == "fit") {
                        t = l.width()
                    }
                }
                l.addClass(t > 50 ? "large" : "");
                var s = h(p, t, o.type);
                if (s == null) {
                    e(this).remove();
                    m.reject({code: f.error.THUMBNAIL_FAILED});
                    return
                }
                var r = s.w, u = s.h;
                if (n.settings.thumbnail == "small") {
                    r = u = t
                }
                e(p).css({"background-image": "url(" + s.src + ")",width: r,height: u}).data("thumb", s.src).attr({src: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQImWNgYGBgAAAABQABh6FO1AAAAABJRU5ErkJggg=="}).show();
                m.resolve()
            }).one("error", function() {
                l.find("img").remove();
                m.reject({code: f.error.IMAGE_LOAD_FAILED})
            });
            p.src = q.target.result
        };
        k.onerror = function(p) {
            m.reject({code: f.error.FILE_LOAD_FAILED})
        };
        k.readAsDataURL(o);
        return m.promise()
    };
    var h = function(n, s, q) {
        var r = n.width, o = n.height;
        if (r > s || o > s) {
            if (r > o) {
                o = parseInt(s / r * o);
                r = s
            } else {
                r = parseInt(s / o * r);
                o = s
            }
        }
        var m;
        try {
            var l = document.createElement("canvas");
            l.width = r;
            l.height = o;
            var k = l.getContext("2d");
            k.drawImage(n, 0, 0, n.width, n.height, 0, 0, r, o);
            m = l.toDataURL()
        } catch (p) {
            m = null
        }
        if (!(/^data\:image\/(png|jpe?g|gif);base64,[0-9A-Za-z\+\/\=]+$/.test(m))) {
            m = null
        }
        if (!m) {
            return null
        }
        return {src: m,w: r,h: o}
    };
    e.fn.ace_file_input = function(m, n) {
        var l;
        var k = this.each(function() {
            var q = e(this);
            var p = q.data("ace_file_input");
            var o = typeof m === "object" && m;
            if (!p) {
                q.data("ace_file_input", (p = new f(this, o)))
            }
            if (typeof m === "string") {
                l = p[m](n)
            }
        });
        return (l === c) ? k : l
    };
    e.fn.ace_file_input.defaults = {style: false,no_file: "No File ...",no_icon: "fa fa-upload",btn_choose: "Choose",btn_change: "Change",icon_remove: "icon-remove",droppable: false,thumbnail: false,before_change: null,before_remove: null,preview_error: null}
})(window.jQuery);