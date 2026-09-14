
vim.opt_local.expandtab = false
vim.opt.suffixesadd:append({ '.txt', '.md' })

local function set_iabbrs()
    vim.cmd([[ """ iabbrs

iabbr t the
iabbr n and
iabbr b but
iabbr dn don't
iabbr din didn't
iabbr ds does
iabbr dsn doesn't

iabbr d this
iabbr da that
iabbr das that's
iabbr il I'll
iabbr im I'm
iabbr ive I've
iabbr id I'd
iabbr isn isn't
iabbr aren aren't
iabbr rn aren't
iabbr hes he's
iabbr shes she's
iabbr shed she'd
iabbr lets let's

iabbr wer were
iabbr wern weren't
iabbr were we're
iabbr wasn wasn't
iabbr wasnt wasn't
iabbr r are
iabbr u you
iabbr ur your
iabbr urs yours
iabbr ru are you
iabbr ure you're
iabbr ud you'd
iabbr uv you've
iabbr fo for
iabbr cant can't
iabbr wont won't

" self
iabbr mysl myself
iabbr ursl yourself
iabbr urslv yourselves
iabbr himsl himself
iabbr oursl ourselves

iabbr cd could
iabbr cdn couldn't
iabbr wd would
iabbr wdn wouldn't
iabbr wdv would've
iabbr sd should
iabbr sdn shouldn't

" coulda, shoulda, woulda
" would've should've

iabbr gona going to
iabbr wana want to
iabbr wena went to

" iabbr cudt couldn't
" iabbr cdut couldn't
" iabbr cudn couldn't
" iabbr cdun couldn't
" iabbr wud would
" iabbr wudn wouldn't
" iabbr wudv would've

" x for thi
iabbr xn thing
iabbr xin thing
iabbr xns things
iabbr noxn nothing
iabbr noxin nothing
iabbr xnk think
iabbr xnks thinks
iabbr xnkn thinking

iabbr tr there
iabbr trs there's
iabbr trf therefore

" 5Ws, When, Where, Who, What, Why
iabbr wn when
iabbr wr where
iabbr whos who's
iabbr whod who'd
iabbr wut what
iabbr wuts what's
iabbr wute whatever
iabbr y why
" some, any, thing, where
iabbr sm some
iabbr smx something
iabbr smxs somethings
iabbr smw somewhere
iabbr smt sometime
iabbr smts sometimes
iabbr smb somebody
iabbr smo someone
iabbr anx anything
iabbr ano anyone
iabbr anyo anyone
iabbr anw anywhere
iabbr ant anytime
iabbr anb anybody
iabbr evo everyone
iabbr evx everything
iabbr evw everywhere
iabbr evt everytime
iabbr evb everybody
iabbr evbs everybody's

" other
iabbr bt about

" att は打ちにくい, ath でもいいかも～
iabbr athe at the
iabbr az at the
" iabbr ot of the
" 改良の余地はありそう

" might = myt
" 自分で作ってた速記の時のような idea だけど igh を y に置き換えられるかも
" ただ my 自体が打ちにくいのは欠点 mp とかで代用できるかを検討したい
" p = ight でもいいかもしれないけど
" j は相当いい候補かも……。発音も文字も似てるし
" [igh を含む word List](https://www.thefreedictionary.com/words-containing-igh)

iabbr mp might
iabbr lp light
iabbr lps lights
iabbr lpn lighting
iabbr sunlp sunlight
iabbr delp delight
iabbr delped delighted
iabbr daylp daylight
iabbr rp right
iabbr rps rights
iabbr outrp outright
iabbr hp hight
iabbr np night
iabbr nps nights
iabbr knp knight
iabbr tonp tonight
iabbr midnp midnight
iabbr sp sight
iabbr spn sighting
iabbr spns sightings
iabbr fp fight
iabbr fpn fighting
iabbr fps fights
iabbr fop fought
iabbr ep eight
iabbr epeen eighteen
iabbr ept eighty

" thing = x, xin
" anything = anyx, anyxin
"
" some -> sm
" somewhere -> smw
" z -> th? まぁ the, tha を z (zt -> that), thi を x とかでもいいかも。
" zn -> then
" zy -> they
" zyl -> they'll
" zou -> thought
" zm -> them  (etc.)
" mozr -> mother
" zin, xin, xn -> thing
" xnk -> think
" }

" the は z のほうがいいかも。まぁでも atz (at the) は打ちにくい
iabbr isa is a
iabbr ist is the
iabbr isz is the
iabbr ina in a
iabbr inan in an
iabbr inz in the
iabbr inda in that
iabbr toz to the
iabbr intoz into the
iabbr ontoz onto the
iabbr foa for a
iabbr foan for an
iabbr foz for the
iabbr obz of the
iabbr ofz of the
iabbr ofa of a
iabbr oba of a
iabbr ofan of an
iabbr oban of an
iabbr alob all of
iabbr alb all of
iabbr alof all of
iabbr lota lot of
iabbr outa out of
iabbr sorta sort of
iabbr onz on the
iabbr ona on a

iabbr ev every
iabbr cuz because
iabbr lil little

" 'll
iabbr ul you'll
iabbr hel he'll
iabbr shel she'll
iabbr wel we'll
iabbr itl it'll

" z for the, tha
iabbr zir their
iabbr zn then
iabbr zm them
iabbr zmsl themselves
iabbr zy they
iabbr zyl they'll
iabbr zyr they're
iabbr moz mother
iabbr mozs mothers
iabbr faz father
iabbr fazs fathers
iabbr oz other
iabbr ozs others
iabbr anoz another
iabbr broz brother
iabbr brozs brothers
iabbr dauz daughter
iabbr togz together
iabbr boz bother
iabbr raz rather
iabbr eiz either

" Weather なども含めるかどうか。ここまでくると，別の Key にすべく思える

iabbr zout thought
iabbr zou though
iabbr zoh though
iabbr alzou although
iabbr alzoh although
iabbr zse these
iabbr zs those
iabbr throu through

" [vim aabbreviation and short-hand](https://vitalyparnas.com/guides/vim-abbrev/)
iabbr k can
iabbr kn can't
iabbr kw know
iabbr kws knows
iabbr ag again
iabbr af after
iabbr afnoon afternoon
iabbr w with
iabbr wo without
iabbr nec necessary
iabbr h have
iabbr hn haven't
iabbr p part
iabbr pp people
iabbr f from

" n-gram 考察
" real deal などの eal は，打ちにくくないので，short-hand の価値は低い
" ace は，打ちにくい割に高頻度
" ive も，短縮する価値あり
" lin も超高頻度で，打ちにくく，置き換えられてば縦連を防げるパターンも多い
" yk link
" yks links
" ye line
" yes? lines
" airyes airlines
" onye online
" Bery? Berlin
" まぁ，y
" だと，縦連の方がましのレベルで遠いけど。ただ，ただ，縦連ごと置換すれば……
" kiy killing
" sey selling
" timeye timeline
" yked linked
" roy rolling
" yux Linux
" wresty wresling
" wesy wrestling
" decye decline
" decyed declined
" ruy ruling
" fay falling
" bowy bowling
" year? linear
" cyder cylinder
" tey telling
" fey feeling
" feys feelings
" vioy violin
" cyical clinical
" deay dealing
" handy? handling
" handyg handling
" travey traveling
" stary sterling
" byd blind
" discipye discipline
" wiy willing
" spey spelling
" incyatino inclineation
" incye incline
" incyed inclined
" stiry stirling
" yeup lineup
" siay sailing
" fyt flint "（フリント）石器，火打ち石。非常に硬い石で先史の素材。硬いもの
" cyic clinic " (13000位)
" roy rolling
" ceiy ceiling
" storye storyline
" storyye storyline
" yking linking
" ykn linking
" controy controlling
" dary darling
" signay signaling
" hury hurling " (放り投げること, 9587位)
" cycy cycling
" modey modeling
" modeling で 9955位。10000位以内では最後。前後には linguistic, healing,
" disciplines, pauline, siblings, airliners, ling, cooling, lined,
" revealing, liner, filling, enabling, guidelines, gambling 等 12000位まで
" lin は名前や，地名に多く出現するが，それは含めなかった。

" mo for motion
" promo promotion
" emo emotion
" emon emotional
" あんまり効果的ではない……。
" o for tion, otion
" populo population
" populao population
" internonal international
" internaonal international
" sto station
" info information
" assoco association
" loco location

"" iabbr でややこしいもの
" their - zir
" haven't - hn
" than - than
" at the - athe
" thought - zou
" through - throu
" anything - anx
" togz - together

]])
end

vim.api.nvim_create_user_command('EngShorthand', set_iabbrs, { nargs = 0, desc = 'Eng short hand mode' })

vim.api.nvim_create_user_command('EngShorthandClear', function()
    vim.cmd('iabclear')
end, { nargs = 0, desc = 'Disabled Eng short hand mode' })
