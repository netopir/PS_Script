$password = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.abcdefghijklmnopqrstuvwxyz.0123456789"
# Letters and Numbers
$archivepassword = $password.Replace('a','@').Replace('A','@'). `
                             Replace('b','ß').Replace('B','ß'). `
                             Replace('c','Ӿ').Replace('C','Ӿ'). `
                             Replace('d','Δ').Replace('D','Δ'). `
                             Replace('e','€').Replace('E','€'). `
                             Replace('f','Д').Replace('F','Д'). `
                             Replace('g','Б').Replace('G','Б'). `
                             Replace('h','Ж').Replace('H','Ж'). `
                             Replace('i','Ψ').Replace('I','Ψ'). `
                             Replace('j','П').Replace('J','П'). `
                             Replace('k','Σ').Replace('K','Σ'). `
                             Replace('l','Γ').Replace('L','Γ'). `
                             Replace('m','₿').Replace('M','₿'). `
                             Replace('n','И').Replace('N','И'). `
                             Replace('o','φ').Replace('O','φ'). `
                             Replace('p','δ').Replace('P','δ'). `
                             Replace('r','Я').Replace('R','Я'). `
                             Replace('s','§').Replace('S','§'). `
                             Replace('t','π').Replace('T','π'). `
                             Replace('u','µ').Replace('U','µ'). `
                             Replace('v','Λ').Replace('V','Λ'). `
                             Replace('w','Ω').Replace('W','Ω'). `
                             Replace('x','Ξ').Replace('X','Ξ'). `
                             Replace('y','¥').Replace('Y','¥'). `
                             Replace('z','£').Replace('Z','£'). `
                             Replace('.',''). `
                             Replace('-',''). `
                             Replace(' ',''). `
                             Replace('0','ↀ'). `
                             Replace('1','Ⅸ'). `
                             Replace('2','Ⅷ'). `
                             Replace('3','Ⅶ'). `
                             Replace('4','Ⅵ'). `
                             Replace('5','Ⅴ'). `
                             Replace('6','Ⅳ'). `
                             Replace('7','Ⅲ'). `
                             Replace('8','Ⅱ'). `
                             Replace('9','Ⅰ')
Write-Output $archivepassword