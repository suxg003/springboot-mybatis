/* 
 * Format amount from pure number to money format.
 * e.g. 1234567 -> 1,234,567
 */
function formatAmount(s, n, unit) {
    n = n > 0 && n <= 20 ? n : 0;
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
    var l = s.split(".")[0].split("").reverse();
    var r = s.split(".")[1];
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