/**
 * Iconfont icon set component.
 * Usage: <Iconfont name="icon-name" size={20} color="#4F8EF7" />
 */

import {createIconSet} from 'react-native-vector-icons';
const glyphMap = ${glyphMap};

let Iconfont = createIconSet(glyphMap, 'iconfont', 'iconfont.ttf');

module.exports = Iconfont;
module.exports.glyphMap = glyphMap;
