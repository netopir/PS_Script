$password = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz.0123456789"
# Letters and Numbers
$archivepassword = $password.Replace('a','@').Replace('A','@'). `
                             Replace('b','ß').Replace('B','ß'). `
                             Replace('c','¢').Replace('C','¢'). `
                             Replace('d','¥').Replace('D','¥'). `
                             Replace('e','€').Replace('E','€'). `
                             Replace('f','Γ').Replace('F','Γ'). `
                             Replace('g','Φ').Replace('G','Φ'). `
                             Replace('h','₧').Replace('H','₧'). `
                             Replace('i','!').Replace('I','('). `
                             Replace('j','¿').Replace('J',')'). `
                             Replace('k','Σ').Replace('K','Σ'). `
                             Replace('l','¡').Replace('L','['). `
                             Replace('m','µ').Replace('M','µ'). `
                             Replace('n','Θ').Replace('N','Θ'). `
                             Replace('o','Ω').Replace('O','Ω'). `
                             Replace('p','§').Replace('P','§'). `
                             Replace('r','?').Replace('R',']'). `
                             Replace('s','$').Replace('S','$'). `
                             Replace('t','π').Replace('T','π'). `
                             Replace('u','∩').Replace('U','∩'). `
                             Replace('v','Æ').Replace('V','Æ'). `
                             Replace('w','#').Replace('W','{'). `
                             Replace('x','&').Replace('X','&'). `
                             Replace('y','%').Replace('Y','}'). `
                             Replace('z','Σ').Replace('Z','Σ'). `
                             Replace('.',''). `
                             Replace('-',''). `
                             Replace(' ',''). `
                             Replace('0','('). `
                             Replace('1','['). `
                             Replace('2','{'). `
                             Replace('3','<'). `
                             Replace('4','='). `
                             Replace('5','~'). `
                             Replace('6','>'). `
                             Replace('7','}'). `
                             Replace('8',']'). `
                             Replace('9',')')
Write-Output $archivepassword