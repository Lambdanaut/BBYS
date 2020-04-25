pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- bbys
-- by lambdanaut
a=16
b=16
c=0
d=1
e=2
f=3
g=4
h=5
i={c,d,e,f}
j={69,70,71,72,73,74,75,76,85,86,87,88,89,90,91,92}
k={32,33,34,35,36,37,38,39,48,49,50,51,52,53,54,55}
l=144
m={
"JON","BETTY","SAL","CAT","JOSH","K8E","JACK","ANDY","SCOTT","ERICA","JOEL",
"NOODL","JEFF","GORBY","VINNY","BBYCAKE","BBYJESUS","TIPPR","DAN","LUA","LUNA",
"GOOBY","GARFO","BBYHITLR","CARL","MARI","CONWAY","GARTH",
"MARK","TOM","SPUD","ADRI","LINDA","RAINY","FROGI","MARSHL","SEAN","SANS","ANG","GENO",
"DASY","BRIT","KYLE","TESS","NIC","NICK","RYAN","HALY","TERAN","WINDI","KENNY"
}
n=0
o=1
p=2
q=3
r=0
s=1
t=2
u=3
r=4
v=5
w=6
x=7
y=8
z=9
ba=10
bb=11
bc=12
bd=13
be=14
bf=15
r=16
bg=50
bh=0
bi=20
bj=3
bk={0,0}
bl={8,0}
bm={17,0}
bn={17,8}
bo={17,17}
bp={8,17}
bq={0,17}
br={0,8}
bs=true
bt=false
bu=true
bv=0.0
bw=0.0
function _init()
print("welcome 🅾️_🅾️♥")
music(bg,0,bj)
end
function _update()
local bx=time()
bw=bx-bv
bv=bx
if bs then
by()
elseif bt then
bz()
else
ca:cb()
local cc={cd}
ce(cc,cf)
ce(cc,cg)
ce(cc,ch)
ce(cc,ci)
ce(cc,cj)
ce(cc,ck)
if cl then add(cc,cl) end
if cm then add(cc,cm) end
for cn,co in pairs(cc) do
co:cb()
end
end
end
function _draw()
if bs then
cp()
elseif bt then
cq()
else
cls()
ca:cr()
cs(ca.ct)
for cn,cu in pairs(ch) do
cu:cr()
end
cv()
local cw={cd}
if cl then cw[2]=cl end
if cm then cw[3]=cm end
ce(cw,cf)
ce(cw,cg)
ce(cw,cj)
ce(cw,ci)
ce(cw,ck)
cx(cw,2)
for cn,cy in pairs(cw) do
cy:cr()
end
ca:cz()
end
end
function by()
if(btnp(4)) then
bs=false
da()
end
end
function cp()
rectfill(0,0,128,128,15)
db(2)
dc=time()%2
if(dc<1) then
dd=de(0,96,time()%1)
else
dd=de(96,0,time()%1)
end
df(0,dd)
end
function bz()
if(btnp(4)) then
bt=false
ca:dg()
end
end
function cq()
ca:dh(
di({8,7}),
":(  🐱 BBY DIED 🐱  :(  ",
f)
end
function df(dj,dk)
dl=-1
dm=-1
for dm=0,4 do
for dl=0,15 do
dn=dm*16+dl
spr(192+dn,dl*8+dj,dm*8+dk)
end
end
end
function db(dp)
if dp==nil then dp=1 end
dl=-2
for cn=1,dp do
for cn,dq in pairs(i) do
dl+=2
dm=-1
for cn,dr in pairs(j) do
dm+=1
ds=dl
if(dm%2==0) then ds+=1 end
cs(dq)
spr(dt(dr),ds*8,dm*8)
cv()
end
end
end
end
function di(du)
return{du[1]*8,du[2]*8}
end
function dv(du)
local dw=di(du)
return{dl=dw[1],dm=dw[2],dx=8,dy=8}
end
function dz(ea)
return{ea[1]/8,ea[2]/8}
end
function eb(dl,dm,ec)
local ed=mget(dl,dm)
local ee=fget(ed,ec)
return ee
end
function da()
ca={}
ca.ef=1
ca.eg=1
ca.eh=5
ca.ei={24,28,41,9999,10,30}
ca.ej={dl=8,dm=8,dx=120,dy=120}
ca.ek=di({8.5,2})
ca.el=0
ca.ct=nil
ca.em=en(ca,2.5)
ca.eo=en(ca,20)
ca.ep=function(self)
music(bh,0,bj)
eq()
er()
es()
et()
eu()
ev()
ew()
self.eg=1
end
ca.ex=function(self)
if self.eg==18 and self.ef<4 then
music(bh,0,bj)
end
if self.ef==1 then
if self.eg==1 then
local ey={
{4,3},{4,5},{4,7},{4,9},{4,11},{4,13},
{13,12},{13,10},{13,8},{13,6},{13,4}
}
ev(ey)
self:ez("HI THERE 🅾️O🅾️  ")
sfx(be)
fa=fb({8,6})
if fc then
fa.fd=fc
else
fc=fa.fd
end
elseif self.eg==2 then
self:ez("THIS IS UR BBY! 🅾️U🅾️  ")
sfx(be)
elseif self.eg==3 then
self:ez("MOVE HER WITH A PUSH ♥ ")
sfx(be)
elseif self.eg==4 then
self:ez("SHE HUNGR. BREAK ROCK 4 MILK!!")
sfx(be)
elseif self.eg==5 then
self:ez("BUT MOST IMPORTANT... 🅾️_🅾️  ")
sfx(be)
elseif self.eg==6 then
self:ez("SAVE HER FROM BEIN FOOD ❎~❎  ")
sfx(be)
fe(bp)
elseif self.eg==9 then
fe(bp)
elseif self.eg==12 then
fe(br)
elseif self.eg==13 then
fe(bn)
elseif self.eg==15 then
fe(bn)
elseif self.eg==19 then
fe(bl)
fe(bp)
fe(br)
fe(bn)
end
elseif self.ef==2 then
if self.eg==1 then
self.ct=d
local ey={
{3,4},{5,4},{7,4},{9,4},{11,4},{13,4},
{4,3},{4,5},{4,7},{4,9},{4,11},{4,13},
{13,12},{13,10},{13,8},{13,6},
}
ev(ey)
fa=fb({8,6})
if fc then
fa.fd=fc
end
self:ez("HEWWO! ^o^ SO SRY 2 SEE...")
sfx(be)
elseif self.eg==2 then
self:ez("  ...  ")
sfx(be)
elseif self.eg==3 then
self:ez("WUT ❎∧🅾️ UR BBY ALIVE?   ")
sfx(be)
elseif self.eg==4 then
ff=fb({8,7},d)
if fg then
ff.fd=fg
else
fg=ff.fd
end
self:ez("WELL.. I GIVE U MORE BBY")
sfx(be)
elseif self.eg==5 then
self:ez("GOOD LUCK. >->")
sfx(be)
elseif self.eg==6 then
fe(bp,d)
elseif self.eg==10 then
fe(br,d)
elseif self.eg==15 then
fe(bl)
elseif self.eg==16 then
fe(bn)
elseif self.eg==20 then
fe(bl,d)
elseif self.eg==21 then
fe(bp,d)
elseif self.eg==22 then
fe(bn)
elseif self.eg==23 then
fe(br,d)
end
elseif self.ef==3 then
if self.eg==1 then
self.ct=e
local ey={}
for dl=2,15 do
if(dl%3==1) then
add(ey,{dl,4})
add(ey,{dl,6})
add(ey,{dl,11})
add(ey,{dl,13})
end
end
ev(ey)
self:ez("...")
sfx(be)
fa=fb({8,7})
if fc then
fa.fd=fc
end
ff=fb({8,9},d)
if fg then
ff.fd=fg
end
elseif self.eg==2 then
self:ez("XCUSE ME 🅾️_🅾️  ")
sfx(be)
elseif self.eg==3 then
self:ez("...I MEAN... ♪_♪  ")
sfx(be)
elseif self.eg==4 then
self:ez("R U RLY STIL ALIVE")
sfx(be)
elseif self.eg==5 then
self:ez("TAKE THIS ONE THEN")
sfx(be)
fh=fb({8,8},e)
if fi then
fh.fd=fi
else
fi=fh.fd
end
elseif self.eg==7 then
fe(bq,e)
elseif self.eg==13 then
fe(bo,e)
elseif self.eg==14 then
fe(bn)
elseif self.eg==16 then
fe(br,d)
elseif self.eg==17 then
fe(bq,d)
elseif self.eg==22 then
self:ez("...")
sfx(be)
elseif self.eg==23 then
self:ez("WHAT THE SH*T")
sfx(be)
elseif self.eg==24 then
self:ez("WHY WONT THEY DIE")
sfx(be)
elseif self.eg==25 then
self:ez("WHY DO U PROTECT THEM")
sfx(be)
elseif self.eg==26 then
self:ez("U DONT LOVE THEM")
sfx(be)
elseif self.eg==27 then
self:ez("NOBODY LOVES THEM")
sfx(be)
elseif self.eg==28 then
self:ez("...")
sfx(be)
elseif self.eg==29 then
self:ez("HERE COME THE MNSTERS ☉∧☉   ")
sfx(be)
elseif self.eg==30 then
fe(bm,d)
elseif self.eg==31 then
fe(bl,e)
elseif self.eg==32 then
fe(bp)
elseif self.eg==34 then
fe(bo,d)
elseif self.eg==35 then
fe(br)
end
elseif self.ef==4 then
if self.eg==1 then
self.ct=c
local ey={}
for dl=2,15 do
if(dl%3==1) then
add(ey,{dl,5})
add(ey,{dl,7})
add(ey,{dl,9})
add(ey,{dl,11})
end
end
ev(ey)
fj({68,24})
cl.fk:fl()
self:ez("HEY BUDDI... I THNK MAYBE...")
sfx(be)
local fa=fb({6,14})
local ff=fb({8,14},d)
local fh=fb({10,14},e)
fa.fm.fn=false
if fc then
fa.fd=fc
end
ff.fm.fn=false
if fg then
ff.fd=fg
end
fh.fm.fn=false
if fi then
fh.fd=fi
end
fa.fo[1]+=4
ff.fo[1]+=4
fh.fo[1]+=4
cd.fo[1]+=4
cd.fo[2]+=24
elseif self.eg==2 then
self:ez("WE GOT OFF ON WRONG FOOT.")
sfx(be)
cl.fk:fl()
music(-1,3000)
elseif self.eg==3 then
self:ez("IF ONLY I HAD A heart ♥ ")
sfx(be)
cl.fk:fl()
elseif self.eg==4 then
self:ez("THEN MAYB WE COULD TRY AGAIN")
sfx(be)
cl.fk:fl()
elseif self.eg==5 then
self:ez("I JUST WANTED 2 SAY")
sfx(be)
cl.fk:fl()
elseif self.eg==6 then
self:ez(".welcom to hell mothr fuckr.",
h)
cl.fp.dq=h
sfx(bd)
cl.fk:fl()
music(bi,0,bj)
self.ct=h
cl.fq:fl()
for cn,fr in pairs(cf) do
fr.fm.fn=true
end
elseif self.eg==9 then
fe(bk)
fe(bl,d)
fe(bm,e)
elseif self.eg==14 then
fe(br,e)
fe(bn,d)
fe(bl)
elseif self.eg==19 then
fe(bl)
elseif self.eg==20 then
fe(bq,e)
elseif self.eg==23 then
fe(bo,d)
elseif self.eg==26 then
fe(bq,e)
fe(bo,d)
fe(bl)
elseif self.eg==28 then
fs=fe(bl,h)
fs.ft=0.35
fs.fu.fv=cf[1]
elseif self.eg>39 then
fe(bl)
fe(bq,e)
fe(bo,d)
end
elseif self.ef==5 then
if self.eg==1 then
self.ct=c
music(-1)
self.em:stop()
sfx(bb)
self.eo.fw=function(fx)
rectfill(
0,0,144,144,
7)
end
fj({68,24})
cd.fy=false
self.eo:fl()
elseif self.eg==3 then
self:ez("...")
sfx(be)
elseif self.eg==4 then
self:ez("...MY HEART...")
sfx(be)
elseif self.eg==5 then
self:ez("...U HEALED ME...")
cl.fk:fl()
sfx(be)
elseif self.eg==6 then
self:ez("TY U DA BESS")
cl.fk:fl()
sfx(be)
elseif self.eg==7 then
self:ez("SRY 4 BEIN SUCH A LIL SH*T")
cl.fk:fl()
sfx(be)
elseif self.eg==9 then
self:ez("U KNO I THNK ITS TIME WE...")
cl.fk:fl()
sfx(be)
elseif self.eg==10 then
self:ez("ROLL TEH CREDDO'S! ")
cl.fk:fl()
sfx(be)
end
elseif self.ef==6 then
if self.eg==1 then
self:ez("A GAME BY LAMBDANAUT")
self.ct=c
fz=fb({8,2},f)
fz.fm.fn=false
fz.ga.fn=false
fz.fd="SHARON"
fz.fu=gb(
fz,
cd,
0.7,
10
)
bu=true
elseif self.eg==2 then
fh=fb({8,0},e)
fh.fm.fn=false
fh.ga.fn=false
if fi then
fh.fd=fi
end
fh.fu=gb(
fh,
fz,
0.69,
10
)
elseif self.eg==3 then
ff=fb({8,0},d)
ff.fm.fn=false
ff.ga.fn=false
if fg then
ff.fd=fg
end
ff.fu=gb(
ff,
fh,
0.68,
10
)
elseif self.eg==4 then
fa=fb({8,0})
fa.fm.fn=false
fa.ga.fn=false
if fc then
fa.fd=fc
end
fa.fu=gb(
fa,
ff,
0.67,
10
)
end
end
end
ca.gc=function(self)
self.ef=5
self:ep()
self:ex()
end
ca.dg=function(self)
self:gd()
self:ep()
self:ex()
end
ca.gd=function(self)
ci={}
cj={}
ch={}
cg={}
cf={}
cl=nil
end
ca.cz=function(self)
self.eo:cb()
self.em:cb()
end
ca.cb=function(self)
self.el+=bw
if(btnp(5)) then
sfx(w)
bu=not bu
end
self:ge()
if self.el>self.eh then
self.el=0
self.eg+=1
self:ex()
end
local ei=self.ei[self.ef]
if not ei then
self.ef=1
self.eg=1
bs=true
elseif self.eg>self.ei[self.ef] then
self.el=0
self.ef+=1
self:gd()
self:ep()
self:ex()
end
end
ca.cr=function(self)
cs(self.ct)
camera(8,8)
map(0,0,0,0,18,18)
cv()
end
ca.ge=function(self)
self:gf(cd)
if cm then
self:gf(cm,8)
end
if self.ef~=6 then
for cn,fr in pairs(cf) do
if self:gf(fr,8) then
fr.gg=true
end
end
end
end
ca.gf=function(self,co,gh)
if not gh then gh=0 end
if co.fo[2]<self.ej.dm+gh then
co.fo[2]=self.ej.dm+gh
return true
elseif co.fo[2]>self.ej.dm+self.ej.dy-gh then
co.fo[2]=self.ej.dm+self.ej.dy-gh
return true
elseif co.fo[1]<self.ej.dl+gh then
co.fo[1]=self.ej.dl+gh
return true
elseif co.fo[1]>self.ej.dl+self.ej.dx-gh then
co.fo[1]=self.ej.dl+self.ej.dx-gh
return true
end
return false
end
ca.ez=function(self,gi,dq,gj,gk)
if gk and self.em.gl>0 then
return
end
self.em.fw=function(fx)
fx:dh(self.ek,gi,dq)
end
if gj then
self.em.gj=gj
else
self.em.gj=5
end
self.em:fl()
end
ca.dh=function(self,gm,gi,dq,gn,go)
if gn or gn==nil then
gp=#gi
else
gp=2
end
local go=go
if go then
local go=max(0.0,go or 1.0)
end
local gq=2
local gr=gm[1]+5-gp*4/2
local gs=gm[2]
local gt=6
if(dq) then
if dq==c then
gt=9
elseif dq==d then
gt=3
elseif dq==e then
gt=12
elseif dq==g then
gt=14
elseif dq==h then
gt=8
end
end
if(gn or gn==nil) then
rectfill(
gr-gq,
gs-gq,
gr+gp*4,
gs+5,
gt)
print(gi,gr,gs-1,0)
end
if(go) then
local gu=0
local gv=8
line(
gr-gq,
gs+5,
gr+gp*4,
gs+5,
gu
)
if(go>0.0) then
local gv=11
if(go<0.25) then
gv=8
elseif(go<0.6) then
gv=10
end
line(
gr-gq,
gs+5,
gr-gq+(((gp*4)+gq)*go),
gs+5,
gv
)
end
end
end
ca:ep()
ca:ex()
return ca
end
function eq(fo)
cd={}
cd.gw=1.0
cd.gx=0.1
cd.fo=di(fo or{8,8})
cd.dn=64
cd.gy={0,0}
cd.fn=true
cd.gz=true
cd.fy=true
cd.ha=2.0
cd.ft=cd.gw
cd.fp=hb(
cd,
0.1,
1,
c,
false)
cd.hc=hd(
cd,
8,
8)
cd.he=en(
cd,1,
function(hf) if flr(hf.he.gl*10)%2==0 then hf.fp.fn=false else hf.fp.fn=true end end,
function(hf) hf.fp.fn=true end
)
cd.cb=function(self)
if self.gz then
self:hg()
end
self.hc:cb()
self:hh()
self.he:cb()
self:hi()
end
cd.hi=function(self)
self.fo=hj(self.fo,self.gy)
end
cd.hg=function(self)
local hk=false
local hl=0
local hm=0
if btn(0) then hl=-self.gw end
if btn(1) then hl=self.gw end
if btn(2) then hm=-self.gw end
if btn(3) then hm=self.gw end
if(hl!=0 or hm!=0) then
hk=true
self.gy={hl,hm}
else
self.gy={0,0}
end
self.fp.hn=hk
if hl>0 then self.fp.ho=true elseif hl<0 then self.fp.ho=false end
end
cd.hh=function(self)
local hp=false
for cn,fr in pairs(cf) do
if self.hc:hq(fr) then
if fr.hr and fr.hr.dn==88 then
self.gw=self.ha
hp=true
end
if fr.gg then
self.hc:hs(fr)
else
sfx(v)
fr.ht=1
local hu=self.hc:hv(fr)
if hu==n then
fr.fo[2]=self.fo[2]-self.hc.rect.dy
elseif hu==o then
fr.fo[2]=self.fo[2]+self.hc.rect.dy
elseif hu==p then
fr.fo[1]=self.fo[1]-self.hc.rect.dx
elseif hu==q then
fr.fo[1]=self.fo[1]+self.hc.rect.dx
end
end
elseif not fr.hw then
fr.ht=0
end
end
if not hp then
self.gw=self.ft
end
if cm and self.hc:hq(cm) then
sfx(v)
local hu=self.hc:hv(cm)
if hu==n then
cm.fo[2]=self.fo[2]-self.hc.rect.dy
elseif hu==o then
cm.fo[2]=self.fo[2]+self.hc.rect.dy
elseif hu==p then
cm.fo[1]=self.fo[1]-self.hc.rect.dx
elseif hu==q then
cm.fo[1]=self.fo[1]+self.hc.rect.dx
end
end
if cl and cl.fn then
local hx=function(hy)
sfx(bf)
self.he:fl()
end
if self.fy then
self.hc:hs(cl,hx,7)
end
end
local hz=function(hf)
hf.fn=false
sfx(bf)
end
for cn,hf in pairs(ck) do
if self.hc:hs(hf,hz,3) then
break
end
end
local ia=false
local ib=function(cu)
if not ia then
cu.ga:ic(self.gx)
ia=true
end
end
for cn,cu in pairs(ch) do
self.hc:hs(cu,ib)
end
end
cd.cr=function(self)
self.fp:cb()
end
end
function er()
ci={}
end
function id(dn,fo)
local ie={}
ie.dn=dn or j[flr(rnd(#j))+1]
ie.fn=true
ie.fo=fo
ie.hc=hd(
ie,
8,
8)
ig=function(ie)
ie.fn=false
end
ie.ga=ih(
ie,
1.0,
nil,
nil,
0.07,
ig
)
ie.cb=function(self)
if self.fn then
self.hc:cb()
self.ga:cb()
end
end
ie.cr=function(self)
if self.fn then
spr(self.dn,self.fo[1],self.fo[2])
end
end
ie.ii=function(self)
return dt(self.dn)
end
ie.ij=function(self,fr)
local ik=self.dn
local dh=function(gi)
ca:ez(gi,g,3.5,true)
end
if ik==69 then
dh("PINK HAT IS UTTERLY USELESS")
elseif ik==70 then
for cn=0,6 do
local fo=di(il())
im(fo)
end
dh("FLOWER GENERATED FOOD")
elseif ik==71 then
for cn,io in pairs(cg) do
if io.fn then
io.ga:ic(1.0)
break
end
end
dh("EYEPATCH ASSASSINATED MONSTER")
elseif ik==72 then
for cn,io in pairs(cg) do
io.fu.fv=nil
end
dh("WIG ATTRACTS MONSTERS")
elseif ik==73 then
for cn=0,10 do
local fo=il()
ip(fo)
end
dh("CROWN GENERATED ROCKS")
elseif ik==74 then
sfx(bb)
for cn,fr in pairs(cf) do
if fr.fn then fr.ga.ga=1.0 end
end
dh("CLOWN NOSE HEALED ALL")
elseif ik==75 then
fr.iq=true
dh("HEADBAND BREAKS ROCKS")
elseif ik==76 then
fr.ga.ir=false
dh("BRA STOPS HUNGER")
elseif ik==85 then
fr.is=true
dh("DRESS HEAL ON CONTACT")
elseif ik==86 then
dh("SUNGLASSES SLOWS MONSTERS")
elseif ik==87 then
dh("BANDANA HURTS MONSTERS")
elseif ik==88 then
dh("PANTS UPS PUSHING SPEED")
elseif ik==89 then
fr.ga.it=false
dh("COAT GIVES INVULNERABILITY")
elseif ik==90 then
sfx(bc)
local iu={cd}
ce(iu,cf)
ce(iu,cg)
for cn,iv in pairs(iu) do
local fo=di(il())
if iv.fn then
iv.fo=fo
end
end
dh("ANTENNAE TELEPORTS YOU")
elseif ik==91 then
for cn,io in pairs(cg) do
io.fu.fv=nil
end
dh("MASK HIDES FROM MONSTERS")
elseif ik==92 then
fr.fm.fn=false
dh("BOX STOPS BBY WANDERING")
end
end
ie.iw=function(self,fr)
local ik=self.dn
if ik==69 then
elseif ik==70 then
elseif ik==71 then
elseif ik==72 then
for cn,io in pairs(cg) do
io.fu.fv=nil
end
elseif ik==73 then
elseif ik==74 then
elseif ik==75 then
fr.iq=false
elseif ik==76 then
fr.ga.ir=true
elseif ik==85 then
fr.is=false
elseif ik==86 then
elseif ik==87 then
elseif ik==88 then
elseif ik==89 then
fr.ga.it=true
elseif ik==90 then
elseif ik==91 then
for cn,io in pairs(cg) do
io.fu.fv=nil
end
elseif ik==92 then
fr.fm.fn=true
end
end
ci[#ci+1]=ie
return ie
end
function dt(ie)
return ie-37
end
function es()
cj={}
end
function im(fo,dn)
local ix={}
ix.fo=fo
ix.fn=true
ix.dn=144
ix.iy=1.0
ix.hc=hd(
ix,
8,
8)
ix.cb=function(self)
self.hc:cb()
end
ix.cr=function(self)
if(self.fn) then
spr(self.dn,self.fo[1],self.fo[2])
end
end
cj[#cj+1]=ix
return ix
end
function ev(iz)
ch={}
ch={}
if iz then
for cn,fo in pairs(iz) do
ip(fo)
end
end
end
function ip(fo)
local cu={}
cu.fo=di(fo or{8,8})
cu.fn=true
cu.dn=60
ig=function(cu)
im(cu.fo)
cu.fn=false
end
cu.ga=ih(
cu,
1.0,
u,
0.4,
nil,
ig,
0.65,
cu.dn+64
)
cu.hc=hd(
cu,
8,
8)
cu.cr=function(self)
if(self.fn) then
spr(self.dn,self.fo[1],self.fo[2])
end
end
cu.cb=function(self)
self.hc:cb()
self.ga:cb()
end
ch[#ch+1]=cu
return cu
end
function ja(fo)
cm={}
cm.dn=31-64
cm.fn=true
cm.fo=fo
cm.fp=hb(
cm,
0.3,
64,
nil,
true)
cm.hc=hd(
cm,
8,
8)
cm.cb=function(self)
if self.fn then
self.hc:cb()
self:hh()
end
end
cm.cr=function(self)
if self.fn then
self.fp:cb()
end
end
cm.hh=function(self)
if cl and cl.fn and self.hc:hq(cl) then
self.fn=false
ca:gc()
end
for cn,cu in pairs(ch) do
self.hc:hs(cu)
end
end
end
function et(jb)
cf={}
if jb then
for jc,fo in pairs(jb) do
cf[jc]=fb(fo)
end
end
end
function fb(fo,dq)
local fr={}
fr.gw=0.5
fr.fd=m[flr(rnd(#m))+1]
fr.fo=di(fo or{8,8})
fr.gy={0,0}
fr.dn=40
fr.fn=true
fr.ht=0
fr.hw=false
fr.gg=false
fr.hr=nil
fr.is=false
fr.iq=false
fr.fp=hb(
fr,
0.3,
64,
dq or c)
fr.hc=hd(
fr,
8,
8)
ig=function(fr)
sfx(x)
bt=true
end
fr.ga=ih(
fr,
1.0,
z,
0.5,
0.01,
ig
)
fr.fm=jd(
fr,
0.2,
1,
0.8,
0.8)
fr.cb=function(self)
if self.fn then
if self.ht>0 then self.fm:stop() else self.fm:je() end
self:hg()
self:hh()
self.hc:cb()
self.ga:cb()
if self.fu then self.fu:cb() end
end
end
fr.cr=function(self)
if self.fn then
self.fp:cb()
local jf=self.fd
ca:dh({self.fo[1],self.fo[2]-8},jf,self.fp.dq,bu,self.ga.ga)
end
end
fr.hg=function(self)
jg=hj(self.fo,self.gy)
self.fo=jg
if(self.gy[1]!=0 or self.gy[2]!=0) then
self.fp.hn=true
else
self.fp.hn=false
end
end
fr.hh=function(self)
self.hw=false
self:jh()
self:ji()
self:jj()
self:jk()
self:jl()
self:jm()
end
fr.jm=function(self)
for cn,hf in pairs(ck) do
if self.hc:hs(hf) then
self.ga:ic(0.2,nil,true)
self.fo=hj(self.fo,hf.gy)
hf.fn=false
break
end
end
end
fr.jl=function(self)
self.gg=false
local ib=function(cu)
if self.iq then
cu.ga:ic(0.99)
end
self.gg=true
end
for cn,cu in pairs(ch) do
self.hc:hs(cu,ib)
end
jn=function(cu)
self.gg=true
end
if cl then
self.hc:hs(cl,jn)
end
if cm then
self.hc:hs(cm,jn)
end
end
fr.jk=function(self)
for cn,ie in pairs(ci) do
if ie.fn and self.hc:hq(ie) then
if self.hr then
self.hr:iw(self)
end
ie:ij(self)
self.dn=ie:ii()
self.hr=ie
ie.fn=false
sfx(t)
end
end
end
fr.jj=function(self)
for cn,ix in pairs(cj) do
if ix.fn and self.hc:hq(ix) then
self.ga:jo(ix.iy)
ix.fn=false
sfx(s)
end
end
end
fr.ji=function(self)
for cn,io in pairs(cg) do
if io.fn and self.hc:hq(io) then
self.ga:ic(io.jp)
if self.hr and self.hr.dn==87 then
io.ga:ic(0.2)
end
end
end
end
fr.jh=function(self)
for cn,jq in pairs(cf) do
if jq~=self then
if self.hc:hq(jq) then
if self.is then
if jq.ga.ga<0.98 then
sfx(s)
jq.ga:jo(0.1)
end
end
if jq.ht==self.ht and self.ht>0 then
jq.ht+=1
end
if jq.ht>self.ht then
self.ht=jq.ht
jq.ht+=1
self.hw=true
local hu=self.hc:hv(jq)
if hu==n then
self.fo[2]=jq.fo[2]+self.hc.rect.dy
elseif hu==o then
self.fo[2]=jq.fo[2]-self.hc.rect.dy
elseif hu==p then
self.fo[1]=jq.fo[1]+self.hc.rect.dx
elseif hu==q then
self.fo[1]=jq.fo[1]-self.hc.rect.dx
end
elseif jq.ht==0 then
local hu=self.hc:hv(jq)
if hu==n then
jq.fo[2]=self.fo[2]-self.hc.rect.dy
elseif hu==o then
jq.fo[2]=self.fo[2]+self.hc.rect.dy
elseif hu==p then
jq.fo[1]=self.fo[1]-self.hc.rect.dx
elseif hu==q then
jq.fo[1]=self.fo[1]+self.hc.rect.dx
end
end
end
end
end
end
cf[#cf+1]=fr
return fr
end
function fj(fo)
cl={}
cl.gw=0.2
cl.fo=fo
cl.dn=47
cl.fn=true
cl.fk=en(
cl,3,
function(hy) hy.fp.hn=true end,
function(hy) hy.fp.hn=false end
)
cl.fq=en(
cl,5,
nil,
function(hy)
jr(hy.fo,1,cd.fo,20)
hy.fq:stop()
hy.fq:fl()
end
)
cl.fq:stop()
cl.hc=hd(
cl,
8,
8)
cl.fp=hb(
cl,
0.1,
64,
f)
function cl.cb(self)
if self.fn then
self.fk:cb()
self.fq:cb()
end
end
function cl.cr(self)
if self.fn then
self.fp:cb()
end
end
end
function ew()
ck={}
ck={}
end
function jr(fo,js,jt,gj)
local hf={}
hf.fo=fo
hf.js=js
hf.jt=jt
hf.gj=gj
hf.dn=15-64
hf.gy=nil
hf.fn=true
hf.hc=hd(
hf,8,8)
ju=function(hf)
hf.fn=false
end
hf.jv=en(hf,hf.gj,nil,jw)
hf.fp=hb(
hf,
0.15,
64,
nil,
true
)
function hf.cb(self)
if self.fn then
self.jv:cb()
self.hc:cb()
self.fo=hj(self.fo,self.gy)
end
end
function hf.cr(self)
if self.fn then
self.fp:cb()
end
end
function hf.jx(self)
local jy=jz(jt,self.fo)
local ka=sqrt(jy[1]^2+jy[2]^2)
local kb=kc(jy)
local gy=kd(kb,self.js)
self.gy=gy
end
hf:jx()
ck[#ck+1]=hf
return hf
end
function eu(ke)
cg={}
if ke then
for cn,fo in pairs(ke) do
fe(fo)
end
end
end
function fe(fo,dq)
local io={}
io.gw=0.18
io.fd=" 🐱  "
io.fo=di(fo or{0,0})
io.gy={0,0}
io.dn=128
io.fn=true
io.jp=0.075
io.ft=io.gw
io.kf=0.12
io.fp=hb(
io,
0.3,
1,
dq or c,
true
)
io.hc=hd(
io,
8,
8)
ig=function(kg)
sfx(y)
if io.fp.dq==h then
ja(kg.fo)
else
id(nil,kg.fo)
end
kg.fn=false
end
io.ga=ih(
io,
1.0,
ba,
0.1,
0.05,
ig
)
kh=function(io)
local ki=nil
for cn,fr in pairs(cf) do
if fr.fn then
local kj=fr.hr and fr.hr.dn==91
if fr.fp.dq==io.fp.dq and not kj then
ki=fr
end
if fr.hr and fr.hr.dn==72 then
ki=fr
break
end
end
end
if ki==nil then
ki=cd
end
return ki
end
io.fu=gb(
io,
nil,
nil,
5,
kh
)
io.cb=function(self)
if self.fn then
self:kk()
self.hc:cb()
self.fu:cb()
self.ga:cb()
self:hg()
end
end
io.cr=function(self)
if self.fn then
self.fp:cb()
ca:dh({self.fo[1],self.fo[2]-8},self.fd,self.fp.dq,bu,self.ga.ga)
end
end
io.hg=function(self)
jg=hj(self.fo,self.gy)
self.fo=jg
end
io.kk=function(self)
self.gw=self.ft
for cn,fr in pairs(cf) do
if fr.fn and fr.hr and fr.hr.dn==86 then
self.gw=self.kf
break
end
end
end
cg[#cg+1]=io
return io
end
function gb(kl,fv,km,kn,kh)
local fu={}
fu.kl=kl
fu.fv=fv
fu.km=km
fu.ko=true
fu.kn=kn
fu.kh=kh
if fu.kh and fu.fv==nil then
fu.fv=fu.kh(fu.kl)
end
fu.cb=function(self)
if self.kh and(self.fv==nil or(self.fv and not self.fv.fn)) then
self.fv=self.kh(self.kl)
end
if self.fv then
local js=self.km or self.kl.gw
local jy=jz(self.fv.fo,self.kl.fo)
if self.kn then
local ka=sqrt(jy[1]^2+jy[2]^2)
if ka<self.kn then
self.kl.gy={0,0}
return
end
end
local kb=kc(jy)
local gy=kd(kb,js)
self.kl.gy=gy
elseif self.kh then
self.kh(self.kl)
end
end
return fu
end
function jd(kl,kp,kq,gj,kr)
local fm={}
fm.kl=kl
fm.kp=kp
fm.kq=kq
fm.gj=gj
fm.kr=kr or 0
fm.ks=0
fm.kt=0
fm.ku=false
fm.fn=true
fm.stop=function(self)
self.ku=false
self.kt=0
self.ks=0-rnd(self.kr)
self.kl.gy={0,0}
end
fm.je=function(self)
if self.fn then
if not self.ku then
self.ks+=bw
if self.ks>self.kq then
local kv=rnd(3)
local kw=rnd(3)
local dl=0
local dm=0
if kv>2 then
dl=self.kp
elseif kv>1 then
dl=-self.kp
else
dl=0
end
if kw>2 then
dm=self.kp
elseif kw>1 then
dm=-self.kp
else
dm=0
end
self.kl.gy={max(dl,self.kl.gy[1]),max(dm,self.kl.gy[2])}
self.ku=true
end
else
self.kt+=bw
if self.kt>self.gj then
self:stop()
end
end
end
end
return fm
end
function hb(kl,kx,ky,dq,hn)
local fp={}
fp.kl=kl
fp.kx=kx
fp.ky=ky
fp.hn=hn or false
fp.fn=true
fp.kz=0
fp.la=0
fp.ho=false
fp.dq=dq
fp.cb=function(self)
self.kz+=bw
if self.fn then
if self.hn and self.kz>self.kx then
self.la=(self.la+1)%2
self.kz=0
end
if(self.dq!=nil) then
cs(self.dq)
end
spr(self:lb(),kl.fo[1],kl.fo[2],1.0,1.0,self.ho)
if(self.dq!=nil) then
cv()
end
end
end
fp.lb=function(self)
if self.hn then
return self.kl.dn+self.ky*(self.la+1)
else
return self.kl.dn
end
end
return fp
end
function hd(kl,dx,dy,gh)
local hc={}
hc.kl=kl
hc.gh=gh or 1
hc.rect={
dl=0,
dm=0,
dx=dx-hc.gh*2,
dy=dy-hc.gh*2}
hc.bx={dl=0,dm=0,dx=0,dy=0}
hc.hy={dl=0,dm=0,dx=0,dy=0}
hc.fx={dl=0,dm=0,dx=0,dy=0}
hc.lc={dl=0,dm=0,dx=0,dy=0}
hc.cb=function(self)
local ld=kl.fo[1]+self.gh
local le=kl.fo[2]+self.gh
self.rect={dl=ld,dm=le,dx=self.rect.dx,dy=self.rect.dy}
self.bx={dl=ld+2,dm=le,dx=self.rect.dx-4,dy=self.rect.dy/2}
self.hy={dl=ld+2,dm=le+self.rect.dy/2,dx=self.rect.dx-4,dy=self.rect.dy/2}
self.fx={dl=ld,dm=le+1,dx=self.rect.dx/2,dy=self.rect.dy-2}
self.lc={dl=ld+self.rect.dx/2,dm=le+1,dx=self.rect.dx/2,dy=self.rect.dy-2}
end
hc:cb()
hc.hq=function(self,lf)
return lg(self.rect,lf.hc.rect)
end
hc.hv=function(self,lf)
local lf=lf.hc.rect
local lh=lg(self.bx,lf)
if(lh) then return n end
local li=lg(self.hy,lf)
if(li) then return o end
local lj=lg(self.fx,lf)
if(lj) then return p end
local lk=lg(self.lc,lf)
if(lk) then return q end
end
hc.hs=function(self,lf,fw,gh)
if lf.fn and self:hq(lf) then
if fw then fw(lf) end
if not gh then gh=0 end
local hu=self:hv(lf)
if hu==n then
self.kl.fo[2]=lf.fo[2]+self.rect.dy+gh
elseif hu==o then
self.kl.fo[2]=lf.fo[2]-self.rect.dy-gh
elseif hu==p then
self.kl.fo[1]=lf.fo[1]+self.rect.dx+gh
elseif hu==q then
self.kl.fo[1]=lf.fo[1]-self.rect.dx-gh
end
return true
end
return false
end
hc.cr=function(self)
for cn,lc in pairs({self.bx,self.hy,self.fx,self.lc}) do
rect(
lc.dl,
lc.dm,
lc.dx+lc.dl-1,
lc.dy+lc.dm-1,
0)
end
end
return hc
end
function ih(kl,
ll,lm,ln,lo,
ig,lp,lq)
local ga={}
ga.kl=kl
ga.ll=ll
ga.ga=ll
ga.ln=ln
ga.lo=lo
ga.ig=ig
ga.lm=lm
ga.lp=lp
ga.lq=lq
ga.lr=ln
ga.lt=0.0
ga.fn=true
ga.it=true
ga.ir=true
ga.cb=function(self)
if self.ln then
self.lr+=bw
end
if self.lo and self.ir then
self.lt+=bw
if(self.lt>1.0) then
self.lt=0
self:ic(self.lo,false)
end
end
end
ga.ic=function(self,ic,lu,lv)
if self.fn and self.it and(lv or self.ln==nil or(self.lr>self.ln)) then
self.ga-=ic
self.lr=0
if self.lm and lu~=false then
sfx(self.lm)
end
if lq and self.ga<self.lp then
self.kl.dn=self.lq
end
if self.ga<=0.0 and self.ig then
self.ig(self.kl)
end
end
end
ga.jo=function(self,ga)
self.ga+=ga
self.ga=min(self.ga,1.0)
end
return ga
end
function en(kl,gj,fw,lw)
local lx={}
lx.kl=kl
lx.gj=gj
lx.fw=fw
lx.lw=lw
ly=false
lx.gl=0
lx.cb=function(self)
if self.gl>0 then
self.gl-=bw
if self.fw then
self.fw(self.kl)
end
elseif not self.lz and self.lw then
self.lz=true
self.lw(self.kl)
end
end
lx.fl=function(self)
self.gl=self.gj
self.lz=false
end
lx.stop=function(self)
self.gl=0
self.lz=true
end
return lx
end
function ma(mb,hy,bx)
return mb+(hy-mb)*bx
end
function de(mb,hy,bx)
local dl
if bx<=1/2.75 then
dl=7.5625*bx*bx
elseif bx<=2/2.75 then
dl=7.5625*(bx-1.5/2.75)^2+.75
elseif bx<=2.25/2.75 then
dl=7.5625*(bx-2.25/2.75)^2+.9375
elseif bx<=1 then
dl=7.5625*(bx-2.625/2.75)^2+.984375
end
return ma(mb,hy,dl)
end
function cs(dq)
if dq==c then
return
elseif dq==d then
pal(9,3)
pal(10,11)
pal(15,11)
elseif dq==e then
pal(9,1)
pal(10,12)
pal(15,6)
pal(4,0)
elseif dq==f then
pal(9,5)
pal(10,6)
pal(15,6)
elseif dq==h then
pal(9,8)
pal(10,6)
pal(15,2)
pal(7,0)
end
end
function cv()
pal(9,9)
pal(10,10)
pal(15,15)
pal(4,4)
pal(7,7)
end
function hj(mc,md)
return{mc[1]+md[1],mc[2]+md[2]}
end
function jz(mc,md)
return{mc[1]-md[1],mc[2]-md[2]}
end
function kd(gy,me)
return{gy[1]*me,gy[2]*me}
end
function mf(gy)
return sqrt(gy[1]^2+gy[2]^2)
end
function kc(gy)
local mg=mf(gy)
return{gy[1]/mg,gy[2]/mg}
end
function mh(mi,mj,mk,ml)
return mj>mk and ml>mi
end
function lg(mm,mn)
local mo=mm.dm
local mp=mo+mm.dy
local mq=mm.dl
local mr=mq+mm.dx
local ms=mn.dm
local mt=ms+mn.dy
local mu=mn.dl
local mv=mu+mn.dx
local mw=mh(mq,mr,mu,mv)
local mx=mh(mo,mp,ms,mt)
return mw and mx
end
function cx(mb,my)
for jc=1,#mb do
local mz=jc
while mz>1 and mb[mz-1].fo[my]>mb[mz].fo[my] do
mb[mz],mb[mz-1]=mb[mz-1],mb[mz]
mz=mz-1
end
end
end
function ce(na,nb)
jc=#na+1
for cn,gy in pairs(nb) do
na[jc]=gy
jc+=1
end
end
function il()
return{flr(rnd(a-2))+2,flr(rnd(b-2))+2}
end
__gfx__
000000007777f77f777777777f7777f97f7777f999999999999999999999999999f7777799f77777000000994999000000000000000000000000000000888800
0000000077f777777f777f7777777f9977777f999f9f9999f9f9f9f99999f9f99f77f7f79f7f7f77000999494999990000000000000000000000000008a99a80
0070070077777f77777f7777777f77f9777f77f9f777f9997f7f7f7f99ff7f7f99f7777799f7777f00999999994449900000000000000000000000008a9aa9a8
00077000f77777777f777f7f7f7777f97f777f9977777f99777777779f7777f79f7f77f79f777777099449949499949000000000000000000000000089a88a98
000770007777f7777777777777777f99777777f977f777f9777f777f99f7f77799f7777799f77f77994999499949999900000000000000000000000089a88a98
0070070077f7777ff7f7f7f7f7f7f999777f7f9977777f997f777f779f77777f9f777f77999ff7f799999499999499990000000000000000000000008a9aa9a8
00000000777777779f9f9f9f9f9f99997f7777f97f7f77f9777f777799f777f799f7777799999f9f99999999f994999900000000000000000000000008a99a80
000000007f7777f7999999999999999977777f9977777f99777777779f77f7779f77f7f79999999999e49999fe999e9900000000000000000000000000888800
000000000000000099999999000000000000000000000000000000000000000000000000000000009ee999eefee99e0900000000000000000000000000000000
000000000000000099999999000000000000000000000000000000000000000000000000000000009e999eeef9e9900900000000000000000000000009000090
0000000000000000999999990000000000000000000000000000000000000000000000000000000090999eeef990900900000000000000000000000008800880
00000000000000009999999900000000000000000000000000000000000000000000000000000000909909eff990900900000000000000000000000087728882
000000000000000099999999000000000000000000000000000000000000000000000000000000009099099ff990900000000000000000000000000088888882
000000000000000099999999000000000000000000000000000000000000000000000000000000000090099ff990900000000000000000000000000008888820
000000000000000099999999000000000000000000000000000000000000000000000000000000000090009ff900900000000000000000000000000009888290
000000000000000099999999000000000000000000000000000000000000000000000000000000000090009ff900000000000000000000000000000000022000
00eeee0000999e0e0e9999000eeeeee00e9ee9e000999900e09999000099990000999900000000000090009ff900000000000000000000000000000000999900
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa90000000000000009f94000000000000000000000000000000097aaa90
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a9000000000000009f94000000000000000000000000000000974aa4a9
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99a2aa2a99a2aa2a9000000000000009ff40000000000000000000000000000009a2aa2a9
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9ee9eeaaee9ee9aa9ee000000000000009ff4000000000000000000000000000000ee9aa9ee
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eeeeeeee09a44a90000000000000009f9400000000000000000000000000000009a44a90
009999000099990000999900009999000099990000999900009999000ee99ee00099990000000000000009ff9940000000000000000000000000000000999900
09900990099009900990099009900990099009900990099009900990099009900990099000000000000009ff9940000000000000000000000000000009900990
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee000000000000000000004ffff940000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e000000000000000000004ffff940000000097900000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae000000000000000000004f999994000000979990000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae000000000000000000049ffff9f9400000979990000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee000000000000000000049ffffff9400009999995000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000499f99999400009999995000000000000000000000000
00eeee000099990000eeee0000eeee0000eeee000099990000999900e099990e0000000000000000000449999994400005999950000000000000000000000000
0eaeeae009900990099ee9900ee00ee00ee00ee00990099009900990eeeeeeee0000000000000000000044444444000000555500000000000000000000000000
0e8eeee00e8eeee00e8eeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
888888808888888088888880000000000000000000000000000eee00ee00000000eeeee0000ee00000000000e000000000e4ee00000000000000000000888800
099a9a90099a9a90099a9a90000000000000000000000000000eee0044e000000eeeeeeee0eeee0e000ee0000e000000eee4eee4000000000000000008a99a80
09aaaa9009aaaa9009aaaa90000000000000000000eeee00ee04e4ee004e000eee4ee4eeeeeeeeee00eeee4000eeeeeeeee4eee4000000000000000008988980
00999990009999900099999000000000000000000eeeeee0eee04eee0004eee4ee4e40ee4444444400eeee4000eeeeeeeee4eee4000000000000000008988980
099eee90099eee90099eee900000000000000000eeeeeeeeee4e44ee0004eee4e444004e00000000004ee4000e44444444404440000000000000000008a99a80
00999990099999900099999000000000000000004444444400eee00000004e404e4004e40000000000044000e400000000000000000000000000000000888800
09900990000009900990000000000000000000000000000000eee000000004000400004000000000000000004000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000eeee00000000000000000000000000000000000000000090000009
0000000000000000000000000000000000000000eeeeeeee0000000000000000077777700eeeeee000000000e000000e0eeeeee4000000000000000008800880
000000000000000000000000000000000000000000eeee447eeee7eeeeeeeeee0eeeeee4eeeeeeeee000000eeeeeeeee0eeeeee4000000000000000087728882
0000000000000000000000000000000000000000000ee400e7eeee7e4eeeeee40ee40ee4eeeeeeeeee0000eee00ee00e0eeeeee4000000000000000088888882
000000000000000000000000000000000000000000eeee00ee744ee704eeee400ee40ee4eeeeeeee4ee00ee4e00ee00e0eeeeee4000000000000000088888882
00000000000000000000000000000000000000000eeeeee044400444004ee4000ee40ee44eeeeee404e40e40eee44eee0eeeeee4000000000000000008888820
0000000000000000000000000000000000000000eeeeeeee00000000000440000ee40ee404eeee40004004004e4004e40eeeeee4000000000000000090888209
0000000000000000000000000000000000000000444444440000000000000000044004400ee44ee0000000000400004004444444000000000000000009022090
00eeee0000999e0e0e9999000eeeeee00e9ee9e000999900e0999900009999000099990000000000000000000000000000000000000000000000000000999900
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa90000000000000000000000000000000000000000000000000097aaa90
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a9000000000000000000000000000000000000000000000000974aa4a9
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99a2aa2a99a2aa2a90000000000000000000000000000000000000000000000009a2aa2a9
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9ee9eeaaee9ee9aa9ee000000000000000000000000000000000000000000000000ee9aa9ee
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eeeeeeee09a44a9000000000000000000000000000000000000000000000000009a44a90
099999000999990009999900099999000999990009999900099999000ee99ee00999990000000000000000000000000000000000000000000000000000999900
00000990000009900000099000000990000009900000099000000990000009900000099000000000000000000000000000000000000000000000000009900990
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e0000000000000000000000000000000000095500000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae0000000000000000000000000000000000955990000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae0000000000000000000000000000000000955990000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee0000000000000000000000000000000009559595000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000000000000000009599955000000000000000000000000
0eeeee000999990009eeee000eeeee000eeeee000999990009999900e999990e0000000000000000000000000000000005999950000000000000000000000000
000eeae000000990000ee99000000ee000000ee00000099000000990eeeeeeee0000000000000000000000000000000000555500000000000000000000000000
00000000900000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a990099a9a0000a9a990099a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90199109099009909019910900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90499409001991009049940900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00911900004994000091190000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09111190909119090911119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
90911909091111909091190900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00644600008878880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00677600888887880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760888787880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760788888870000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760788888700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06777760077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00eeee0000999e0e0e9999000eeeeee00e9ee9e000999900e0999900009999000099990000000000000000000000000000000000000000000000000000999900
0eeeeee0097aaae009eaaa9eeeeeeeee0eeeeee0097aaa900eeeeee0097aaa90097aaa90000000000000000000000000000000000000000000000000097aaa90
974aa4a9974aaeae974eeee9ee4ee4ee974ee4a9974aa4a9e74aa4a9974aa4a9974aa4a9000000000000000000000000000000000000000000000000974aa4a9
9a2aa2a99a2aa2a99a2aeee9ee2ae2ae9a2aa2a99a2ee2a99a2aa2a99a2aa2a99a2aa2a90000000000000000000000000000000000000000000000009a2aa2a9
ee9aa9eeee9aa9eeee9aaeeeee9aa9eeee9aa9eeee9ee9eeee9aa9ee9eeaaee9ee9aa9ee000000000000000000000000000000000000000000000000ee9449ee
09a44a9009a44a9009a44a9009a44a9009a44a9009a44a9009a44a90eeeeeeee09a44a9000000000000000000000000000000000000000000000000009a44a90
009999900099999000999990009999900099999000999990009999900ee99ee00099999000000000000000000000000000000000000000000000000000999900
09900000099000000990000009900000099000000990000009900000099000000990000000000000000000000000000000000000000000000000000009900990
0099990000999900009999000099990000eeee00e099990ee099990eeeeeeeee0000000000000000000000000000000000000000000000000000000000000000
097aaa90097aaa90097aaa90097aaa900eeeeee00e7aaae0eeeeeeeee97aaa9e0000000000000000000000000000000000000000000000000000000000000000
974aa4a97eeee7ee974aa4a9974aa4a9ee4aa4ee974aa4a9e74ee4aee74aa4ae0000000000000000000000000000000000000000000000000000000000000000
9a2aa2a9e7eeee7e9a2aa2a99a2aa2a9ee2aa2ee9a2aa2a9ea2ee2aeea2aa2ae0000000000000000000000000000000000000000000000000000000000000000
ee9aa9eeee7aaee7eeeeeeeeee9aa9eeee9aa9eeee9aa9eeeeeaaeeeee9aa9ee0000000000000000000000000000000000000000000000000000000000000000
09a44a9009a44a900eeeeee009a44a900eeeeee009a44a900ea44ae0e9a44a9e0000000000000000000000000000000000000000000000000000000000000000
00eeeee00099999000eeee9000eeeee000eeeee00099999000999990e099999e0000000000000000000000000000000000000000000000000000000000000000
0eaee00009900000099ee0000ee000000ee000000990000009900000eeeeeeee0000000000000000000000000000000000000000000000000000000000000000
00008888888888888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000888888888888000000000000
00088888888888888888888990000000000000000000000000000000000000000000000000000000000000000000000000000008888888888888888000000000
000888888888888888888889990000000000888888888888888800000000000000088888a0000000000000000000000000000008888888888888888880000000
000888888888888888888889999000000000888888888888888888889000000000888888a0000000000000000000000000000888888888888888888888800000
00088888aaaa888888888888999900000000888888888888888888888990000008888888aa000000000000888880000000008888888888888888888888880000
00088888aa00aaaa88888888999900000000888888888888888888888999000008888888aa000000000008888888800000008888888888888888888888888000
00088888a0000000aaa888888999900000008888888888888888888888999000888888888aa000000000888888888880000088888888aaaaaaaaa88888888000
0008888aa00000000008888889999000000088888aaaaaaaa888888888999000888888888aa00000000888888888888800008888888900000000aaa888888000
0088888aa00000000008888889999000000888888aa000000aa8888888999000888888888aaa000000888888888888990000888888890000000000aa88888000
0088888aa00000000008888889999000000888888aa0000000088888899990008888888888aaa000088888888888899900008888888999000000000aa888a000
0088888aa00000000088888889990000000888888aa0000000088888899900008888888888aaaa008888888888889999000088888888899999000000aaaa0000
0088888aa00000888888888899990000000888888aa00000008888889999000008888888888aaaa8888888888889999000008888888888888999900000000000
00888888888888888888888899990000000888888aaa00000888888999900000088888888888aa88888888888899990000000888888888888888899900000000
008888888888888888888889999000000008888888aa008888888899990000000088888888888888888888888999000000000088888888888888888990000000
00888888888888888888889990000000000888888888888888888999900000000008888888888888888888889999000000000000888888888888888889000000
08888888888888888888889000000000008888888888888888889990000000000000088888888888888888899900000000000000008888888888888888990000
08888888888888888888889000000000008888888888888888889900000000000000008888888888888888999900000000000000000088888888888888890000
08888888888888888888888900000000008888888888888888889999000000000000000088888888888899999000000000000000000000888888888888889000
0888888aaaa888888888888890000000008888888888888888889999990000000000000088888888888999900000000000000000000000000008888888889900
088888aa000aaa888888888899000000008888888888888888888999999900000000000000888888888999000000000000000008800000000000008888889900
088888aa000000aa8888888889000000088888888888888888888899999990000000000000088888888990000000000000000888888000000000000888889900
088888a000000000aa888888899000000888888888aaaaaaaaa88889999999900000000000088888888990000000000000008888888800000000000888889900
88888aa00000000000888888899000000888888888aa000000aaa888999999900000000000088888888990000000000000008888888888000000008888889900
88888aa00000000000888888899000000888888888aa000000000888889999990000000000088888888990000000000000088888888888880000008888889900
88888aa00000000000888888899000000888888888aa000000008888888999990000000000088888888990000000000000088888888888888888888888899900
88888aa00000000008888888999000000888888888aa000000008888888999990000000000088888888990000000000000098888888888888888888888899900
8888888888888888888888899990000088888888888aa00008888888888999990000000000088888888990000000000000099998888888888888888888899900
88888888888888888888889999900000888888888888888888888888889999990000000000088888888990000000000000009999888888888888888888999000
88888888888888888888899999900000999998888888888888888899999999990000000000088888889990000000000000000099998888888888888888999000
99999998888888888889999999000000999999999998899999999999999999000000000000099999999900000000000000000099999998888888888999990000
99999999999999999999999900000000099999999999999999999999990000000000000000000999999000000000000000000009999999999988899999900000
99999999999999999999000000000000000000009999999999999000000000000000000000000000000000000000000000000000999999999999999999000000
__gff__
0000000000000000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012121212121212121212121212121212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012070606060606060606060606060512000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012080101010101010101010101010412000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012090202020202020202020202020312000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0012121212121212121212121212121212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010e00000c4400c4300c4200c4400c4300c4200c4400c4300c4200c4400c4300c4200c4200c4100c4200c4100c4400c4300c4200c4400c4300c4200c4400c4300c4200c4400c4300c4200c4200c4100c4200c410
00090000130501e050290502e0501505006050020500205001000060000c0001600026000360001a0000f0000d0001100016000250003c0001f0001b0001a00019000190001a0000000000000000000000000000
000900000b2501a250282501625035250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0003000019640316302e63031630243301b3300533000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00000055005500025000550005500025000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000600003a1203d110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003f35037250302502b25025250212501c25017250122500e250092500425001250153501e350153501e350143501e3501e3501b3501835016350133501e3501b3500c3500a3500a350073500435004350
000300001515015150141501315012150111500f1500d1500c1500915007150051500d15008150071500615006150031500215001150001500015000000000000000000000000000000000000000000000000000
000400002025020250192500a25002250112500025003250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00090000130501e050290502e0501505006050020500205001050060500c0501605026050360501a0500f0500d0501105016050250503c0501f0501b0501a05019050190501a0500000000000000000000000000
010500000d200152001c200242002c20033200382003220025200000000d20000200042001520000000272003220038200000002920021200092000e200162002620029200362003b20038200262000b20000000
000300003a673346732e67329673246731f6731d6731d6731b6731a67318673176731567313673126730d6730c673086730667304673026730067300673006730066500655006550065500655006550065500655
000a00000b140061500e140061500b14006100001000b100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000300000d7501e7502d7503a7503675023750157500e7500a7500875006750047500475003750027500275001750007500070000700007000070000700017000170001700007000070000700007000070000700
000300000a1701e1702d1703a1703617023170151700e1700a170081700617004170041700317002170061700b170111701b1702f170371701c1701117014170171701c170251703b1703f17037170261700a170
00060000030000e0001c0002500035000340000d000330003c0002c0003e00039000190001a0002200029000210001e000230002b0002f0003b0001400026000310003e000190002100028000330003700011000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01100000180300f0001c030000001f030000002303000000240300100023030010001a0000f000180300100021030140001f0300200021030020001c0300200021030030001a0300600021000040001803005000
011000000c0733f2003f2253f2000c073296000c0733f2150c073000003f22500000246150000029615000000c0733f200296253f2000c07300000296153f2000c073000003f2251b3003f225000003f22500000
011000000c0533f2003f2003f2000c053296000c0003f2000c053000002960000000246150000029600000000c0533f200296153f2000c05300000296153f2000c053000003f2151b3003f215000003f21500000
011000001304113031135211304113531130211354113031130211304113531130211304113011135411301113041130311352113041135311302113541130311302113041135311302113041130111354113011
011000000c7500f70010750000000c7500000010750000001175001000107500e7500c7500f70011750010001175014700107500e7500c7500200015750020001575003000137501175010750040000c75005000
00100000185501d550185501c5001c5501f5501a5500050023550215501f5501d5501f5501d5501c550015001c5501d5501f5501a5001f55021550235500250023550215501f5501d5501c5501a5501855018500
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010f00000e0500e050130500e050130500e0500e050150500e0500e050150500e050180500e050130500e050110500e050100500e050110500e050100500e0500e0500e0500c0500e0500e050100500e0500e050
011000000c0733f2000c0000c0730c000296000c0733f2000c073000000c0000c0730c000000000c073000000c0733f200296000c0730c000000000c0733f2000c073000003f2000c0730c000000000c07300000
011000000c0733f2000c0733f2050c67029600187533f2030c073000001875300000186700000018753000000c0733f2000c0733f2001867000000186703f2000c07300000187531b30018670000001875300000
011000000c0733f2000c0733f2050c67029600187533f2030c073000001875300000186700000018753000000c0733f2000c0733f2001867000000186703f2000c07300000187531b3003f2253f2253f2253f225
011000001855018550245501f5001c5501c5001d5001d5501d5001c550245001a550185501a5501a5001a500185501a5502455000500305500050000500345500050034550005003255030550325500050000500
01100000104420c4300c4200c4420c4300c4200c4420c4300c4200c4420c4300c4200c4220c4100c4200c4100c4420c4300c4200c4420c4300c4200c4420c4300c4200c4420c4300c4200c4220c4100c4200c410
011000000c2740c2742450022274005001d274345001b2741e2740050024300112741c300005000c274303000c2740c2742450022274005001d274345001b27425274252742a274332741c300005000c27430300
011000000c2740c2742450022274005001d274345001b2741e2740050024300112741c300005000c274303000c2740c2742450022274005001d274345001b2742327423274232742f2742f2742f2742f2742f274
01100000185501a550245501f5001c5501c5001d5001d5501d5001c550245001a550185501a5501a5001a500185501a550245500050030550005000050034550005003455000500375503b5503c5503e5503c550
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003a600346002e60029600246001f6001d6001d6001b6001a60018600176001560013600126000d6000c600086000660004600026000060000600006000060000600006000160000600016000060000600
__music__
01 57174344
01 56174b44
00 15175444
00 15175444
00 15171844
00 15171844
00 14175855
00 14175855
00 14185854
01 15141854
00 15145454
00 15145855
00 14175855
00 14171855
00 14171854
00 14171854
00 55571855
00 41421844
00 41424344
00 41424344
00 23626044
00 23206044
00 23206044
00 23242044
00 23242044
00 23242044
01 23252044
00 23200d44
00 23210d44
00 23200d44
00 23210d44
00 22232144
00 22232144
00 22232044
00 26232044
00 23202444
00 23212544
00 23200d44
00 23210d44
00 230d2044
00 23210d44
00 23202244
00 23202644
00 23652044
00 23652044
00 23656044
00 23656044
00 41424344
00 41424344
00 41424344
00 1e424344
00 1e424344

