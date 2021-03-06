/**
 * Iconfont icon set component.
 * Usage: <Iconfont name="icon-name" size={20} color="#4F8EF7" />
 */

import {createIconSet} from 'react-native-vector-icons';
const glyphMap = {
  "aircraft": 58885,
  "dropmenu": 58886,
  "face1": 58887,
  "face2": 58888,
  "face3": 58889,
  "face4": 58890,
  "face5": 58891,
  "selected": 58894,
  "hippletext": 58880,
  "hipplelogol": 58881,
  "hipplelogos": 58882,
  "img": 58900,
  "go": 58901,
  "hotel": 58909,
  "debug": 58910,
  "sub": 58912,
  "key": 58914,
  "tie": 58915,
  "typewalk": 58923,
  "view": 58924,
  "imageb": 58928,
  "iosback": 58929,
  "iosbuy": 58930,
  "ioschooseselected": 58931,
  "iosface2": 58932,
  "iosiconhotel": 58933,
  "ioslikes": 58934,
  "ioslogowhite": 58935,
  "ioslogout": 58936,
  "iosx": 58938,
  "upload": 58939,
  "ios-calendar-arrow": 58940,
  "hippletexts": 58941,
  "ios-points": 58942,
  "ioscoffee": 58943,
  "resend": 58944,
  "photo": 58946,
  "checkboxnormal": 58895,
  "closed_large": 58949,
  "edit": 58950,
  "history": 58951,
  "iconcamera": 58952,
  "logout": 58953,
  "pwhide": 58954,
  "pwshow": 58955,
  "reload": 58956,
  "reorder": 58957,
  "search": 58958,
  "sent": 58959,
  "set": 58925,
  "sub-circle": 58896,
  "switch": 58945,
  "checkboxradio": 58883,
  "ios-star": 58893,
  "transfer": 58902,
  "checkboxselect": 58892,
  "calendar": 58897,
  "add": 58898,
  "info": 58884,
  "back": 58904,
  "direct": 58906,
  "cut": 58905,
  "caretleft": 58908,
  "caretright": 58911,
  "stepbackward": 58913,
  "stepforward": 58918,
  "caretdown": 58919,
  "caretup": 58921,
  "time": 58960,
  "warning": 58903,
  "closed": 58899,
  "dropdown": 58927,
  "star": 58937,
  "locked": 58947,
  "adds": 58948,
  "location": 58916,
  "doubleright": 58920,
  "doubleleft": 58961,
  "pleft": 58962,
  "pright": 58963,
  "lockopen": 58964,
  "unlocked": 58965,
  "trash": 58926,
  "toggle": 58966,
  "img1": 58967,
  "img2": 58968,
  "img3": 58969,
  "top": 58970,
  "imgtitleblue": 58971,
  "imgtravel": 58972,
  "hotelparking": 58973,
  "hotelpool": 58974,
  "hotelwifi": 58975,
  "webcustom": 58976,
  "iconselected": 58977,
  "iconunselect": 58978,
  "icontrain": 58979,
  "iconjingdian": 58982,
  "iconeat": 58983,
  "iconboat": 58984,
  "iconbuy": 58985,
  "iconchongdie": 58986,
  "icontaxi": 58917,
  "iconwalk": 58922,
  "iconflight": 58907,
  "icondrive": 58987,
  "iconinfo": 58981,
  "iconalarm": 58988,
  "iconedit": 58989,
  "iconbus": 58990
};

let Iconfont = createIconSet(glyphMap, 'iconfont', 'iconfont.ttf');

module.exports = Iconfont;
module.exports.glyphMap = glyphMap;

