   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.5 - 29 Dec 2015
   3                     ; Generator (Limited) V4.4.4 - 27 Jan 2016
   4                     ; Optimizer V4.4.4 - 27 Jan 2016
  21                     	bsct
  22  0000               _ind:
  23  0000 00            	dc.b	0
  24  0001 00            	dc.b	0
  25  0002 00            	dc.b	0
  26  0003               _tchk:
  27  0003 00            	dc.b	0
  28  0004 00            	dc.b	0
  29  0005 00            	dc.b	0
  30  0006               _numind:
  31  0006 00            	dc.b	0
  32  0007               _fan:
  33  0007 01            	dc.b	1
  34  0008               _fanold:
  35  0008 00            	dc.b	0
  36  0009               _speedfan:
  37  0009 03            	dc.b	3
  38  000a               _speedfanold:
  39  000a 00            	dc.b	0
  40  000b               _temp:
  41  000b 0000          	dc.w	0
  42  000d               _tempold:
  43  000d 0000          	dc.w	0
  44  000f               _timeshownext:
  45  000f 00            	dc.b	0
  46  0010               _showind:
  47  0010 00            	dc.b	0
  48  0011               _spiralpower:
  49  0011 00            	dc.b	0
  50  0012               _spiralon:
  51  0012 00            	dc.b	0
  52  0013               _spiraltime:
  53  0013 0000          	dc.w	0
  54  0015               _wIntegral:
  55  0015 00000000      	dc.l	0
  56  0019               _hKp_Gain:
  57  0019 00e6          	dc.w	230
  58  001b               _hKi_Gain:
  59  001b 0014          	dc.w	20
  60  001d               _kndtime:
  61  001d 00            	dc.b	0
  62  001e               _timenct:
  63  001e 0000          	dc.w	0
  64  0020               _timemcp:
  65  0020 0000          	dc.w	0
  66  0022               _timeuv:
  67  0022 00            	dc.b	0
  68  0023               _rezhim:
  69  0023 00            	dc.b	0
  70  0024               _current_millis:
  71  0024 00000000      	dc.l	0
  72  0028               _kn1:
  73  0028 0000          	dc.w	0
  74  002a               _kn2:
  75  002a 0000          	dc.w	0
  76  002c               _kn1old:
  77  002c 0000          	dc.w	0
  78  002e               _kn2old:
  79  002e 0000          	dc.w	0
  80  0030               _fandes:
  81  0030 0000          	dc.w	0
  82  0032               _fansot:
  83  0032 0000          	dc.w	0
  84                     .const:	section	.text
  85  0000               _cK:
  86  0000               L7:
  87  0000 41c8ab1c      	dc.w	16840,-21732
  88  0004               L71:
  89  0004 3da0f997      	dc.w	15776,-1641
  90  0008               L72:
  91  0008 be802909      	dc.w	-16768,10505
  92  000c               L73:
  93  000c 3daa4bf6      	dc.w	15786,19446
  94  0010               L74:
  95  0010 bc49337a      	dc.w	-17335,13178
  96  0014               L75:
  97  0014 3a8080e2      	dc.w	14976,-32542
  98  0018               L76:
  99  0018 b839188c      	dc.w	-18375,6284
 100  001c               L77:
 101  001c 358df776      	dc.w	13709,-2186
 102  0020               L701:
 103  0020 b234dca7      	dc.w	-19916,-9049
 104  0024               _cKm:
 105  0024               L711:
 106  0024 41c96340      	dc.w	16841,25408
 107  0028               L721:
 108  0028 bf9548eb      	dc.w	-16491,18667
 109  002c               L731:
 110  002c bf8aabaa      	dc.w	-16502,-21590
 111  0030               L741:
 112  0030 bf65d1fc      	dc.w	-16539,-11780
 113  0034               L751:
 114  0034 bebf3166      	dc.w	-16705,12646
 115  0038               L761:
 116  0038 bdb16c74      	dc.w	-16975,27764
 117  003c               L771:
 118  003c bc2b38fc      	dc.w	-17365,14588
 119  0040               L702:
 120  0040 ba081b4f      	dc.w	-17912,6991
 121  0044               _cKf:
 122  0044               L712:
 123  0044 c303ce48      	dc.w	-15613,-12728
 124  0048               L722:
 125  0048 42413579      	dc.w	16961,13689
 126  004c               L732:
 127  004c bfd2b124      	dc.w	-16430,-20188
 128  0050               L742:
 129  0050 3d5fd5db      	dc.w	15711,-10789
 130  0054               L752:
 131  0054 ba7cfcda      	dc.w	-17796,-806
 132  0058               L762:
 133  0058 3713ad21      	dc.w	14099,-21215
 134  005c               L772:
 135  005c b3059bb7      	dc.w	-19707,-25673
 232                     	switch	.const
 233  0060               L6:
 234  0060 000222e1      	dc.l	140001
 235  0064               L01:
 236  0064 00000200      	dc.l	512
 237  0068               L21:
 238  0068 000007d0      	dc.l	2000
 239  006c               L41:
 240  006c 00000047      	dc.l	71
 241                     ; 161 s16 PI_Regulator(s16 hReference, s16 hPresentFeedback)
 241                     ; 162 {
 242                     	scross	off
 243                     .text:	section	.text,new
 244  0000               _PI_Regulator:
 246  0000 89            	pushw	x
 247  0001 5210          	subw	sp,#16
 248       00000010      OFST:	set	16
 251                     ; 167   wError= (s32)(hReference - hPresentFeedback);
 253  0003 72f015        	subw	x,(OFST+5,sp)
 254  0006 cd0000        	call	c_itolx
 256  0009 96            	ldw	x,sp
 257  000a 1c0009        	addw	x,#OFST-7
 258  000d cd0000        	call	c_rtol
 261                     ; 170   wProportional_Term = hKp_Gain * wError;
 263  0010 be19          	ldw	x,_hKp_Gain
 264  0012 cd0000        	call	c_itolx
 266  0015 96            	ldw	x,sp
 267  0016 1c0009        	addw	x,#OFST-7
 268  0019 cd0000        	call	c_lmul
 270  001c 96            	ldw	x,sp
 271  001d 1c0005        	addw	x,#OFST-11
 272  0020 cd0000        	call	c_rtol
 275                     ; 173   if (hKi_Gain == 0)
 277  0023 be1b          	ldw	x,_hKi_Gain
 278                     ; 175     wIntegral = 0;
 280  0025 2777          	jreq	LC002
 281                     ; 179     wIntegral_Term = hKi_Gain * wError;
 283  0027 cd0000        	call	c_itolx
 285  002a 96            	ldw	x,sp
 286  002b 1c0009        	addw	x,#OFST-7
 287  002e cd0000        	call	c_lmul
 289  0031 96            	ldw	x,sp
 290  0032 1c0009        	addw	x,#OFST-7
 291  0035 cd0000        	call	c_rtol
 294                     ; 180     wIntegral_sum_temp = wIntegral + wIntegral_Term;
 296  0038 ae0015        	ldw	x,#_wIntegral
 297  003b cd0000        	call	c_ltor
 299  003e 96            	ldw	x,sp
 300  003f 1c0009        	addw	x,#OFST-7
 301  0042 cd0000        	call	c_ladd
 303  0045 96            	ldw	x,sp
 304  0046 1c000d        	addw	x,#OFST-3
 305  0049 cd0000        	call	c_rtol
 308                     ; 182 		if (wIntegral_sum_temp > 0)
 310  004c 96            	ldw	x,sp
 311  004d 1c000d        	addw	x,#OFST-3
 312  0050 cd0000        	call	c_lzmp
 314  0053 2d11          	jrsle	L363
 315                     ; 184 			if (wIntegral < 0)
 317  0055 720f001527    	btjf	_wIntegral,#7,L173
 318                     ; 186 				if (wIntegral_Term < 0)
 320  005a 7b09          	ld	a,(OFST-7,sp)
 321  005c 2a23          	jrpl	L173
 322                     ; 188 					wIntegral_sum_temp = S32_MIN;
 324  005e 5f            	clrw	x
 325  005f 1f0f          	ldw	(OFST-1,sp),x
 326  0061 ae8000        	ldw	x,#-32768
 327  0064 2019          	jp	LC001
 328  0066               L363:
 329                     ; 194 			if (wIntegral > 0)
 331  0066 ae0015        	ldw	x,#_wIntegral
 332  0069 cd0000        	call	c_lzmp
 334  006c 2d13          	jrsle	L173
 335                     ; 196 				if (wIntegral_Term > 0)
 337  006e 96            	ldw	x,sp
 338  006f 1c0009        	addw	x,#OFST-7
 339  0072 cd0000        	call	c_lzmp
 341  0075 2d0a          	jrsle	L173
 342                     ; 198 					wIntegral_sum_temp = S32_MAX;
 344  0077 aeffff        	ldw	x,#65535
 345  007a 1f0f          	ldw	(OFST-1,sp),x
 346  007c ae7fff        	ldw	x,#32767
 347  007f               LC001:
 348  007f 1f0d          	ldw	(OFST-3,sp),x
 350  0081               L173:
 351                     ; 203     if (wIntegral_sum_temp > wUpper_Limit_Integral)
 353  0081 96            	ldw	x,sp
 354  0082 1c000d        	addw	x,#OFST-3
 355  0085 cd0000        	call	c_ltor
 357  0088 ae0060        	ldw	x,#L6
 358  008b cd0000        	call	c_lcmp
 360  008e 2f0a          	jrslt	L773
 361                     ; 205       wIntegral = wUpper_Limit_Integral;
 363  0090 ae22e0        	ldw	x,#8928
 364  0093 bf17          	ldw	_wIntegral+2,x
 365  0095 ae0002        	ldw	x,#2
 367  0098 200f          	jra	L163
 368  009a               L773:
 369                     ; 207     else if (wIntegral_sum_temp < wLower_Limit_Integral)
 371  009a 7b0d          	ld	a,(OFST-3,sp)
 372  009c 2a05          	jrpl	L304
 373                     ; 209       wIntegral = wLower_Limit_Integral;
 375  009e               LC002:
 377  009e 5f            	clrw	x
 378  009f bf17          	ldw	_wIntegral+2,x
 380  00a1 2006          	jra	L163
 381  00a3               L304:
 382                     ; 213       wIntegral = wIntegral_sum_temp;
 384  00a3 1e0f          	ldw	x,(OFST-1,sp)
 385  00a5 bf17          	ldw	_wIntegral+2,x
 386  00a7 1e0d          	ldw	x,(OFST-3,sp)
 387  00a9               L163:
 388  00a9 bf15          	ldw	_wIntegral,x
 389                     ; 217   houtput_32 = (wProportional_Term/hKp_Divisor+wIntegral/hKi_Divisor);
 391  00ab ae0015        	ldw	x,#_wIntegral
 392  00ae cd0000        	call	c_ltor
 394  00b1 ae0068        	ldw	x,#L21
 395  00b4 cd0000        	call	c_ldiv
 397  00b7 96            	ldw	x,sp
 398  00b8 5c            	incw	x
 399  00b9 cd0000        	call	c_rtol
 402  00bc 96            	ldw	x,sp
 403  00bd 1c0005        	addw	x,#OFST-11
 404  00c0 cd0000        	call	c_ltor
 406  00c3 ae0064        	ldw	x,#L01
 407  00c6 cd0000        	call	c_ldiv
 409  00c9 96            	ldw	x,sp
 410  00ca 5c            	incw	x
 411  00cb cd0000        	call	c_ladd
 413  00ce 96            	ldw	x,sp
 414  00cf 1c000d        	addw	x,#OFST-3
 415  00d2 cd0000        	call	c_rtol
 418                     ; 219   if (houtput_32 > hUpper_Limit_Output)
 420  00d5 96            	ldw	x,sp
 421  00d6 1c000d        	addw	x,#OFST-3
 422  00d9 cd0000        	call	c_ltor
 424  00dc ae006c        	ldw	x,#L41
 425  00df cd0000        	call	c_lcmp
 427  00e2 2f08          	jrslt	L704
 428                     ; 221     houtput_32 = hUpper_Limit_Output;		  			 	
 430  00e4 ae0046        	ldw	x,#70
 431  00e7 1f0f          	ldw	(OFST-1,sp),x
 432  00e9 5f            	clrw	x
 434  00ea 2007          	jp	LC003
 435  00ec               L704:
 436                     ; 223   else if (houtput_32 < hLower_Limit_Output)
 438  00ec 7b0d          	ld	a,(OFST-3,sp)
 439  00ee 2a05          	jrpl	L114
 440                     ; 225     houtput_32 = hLower_Limit_Output;
 442  00f0 5f            	clrw	x
 443  00f1 1f0f          	ldw	(OFST-1,sp),x
 444  00f3               LC003:
 445  00f3 1f0d          	ldw	(OFST-3,sp),x
 447  00f5               L114:
 448                     ; 227   return((s16)(houtput_32)); 		
 450  00f5 1e0f          	ldw	x,(OFST-1,sp)
 453  00f7 5b12          	addw	sp,#18
 454  00f9 81            	ret	
 564                     ; 232 char* shift_and_mul_utoa16(uint16_t n, char *buffer)
 564                     ; 233 {
 565                     .text:	section	.text,new
 566  0000               _shift_and_mul_utoa16:
 568  0000 89            	pushw	x
 569  0001 5208          	subw	sp,#8
 570       00000008      OFST:	set	8
 573                     ; 237         d1 = (n>>4)  & 0xF;
 575  0003 54            	srlw	x
 576  0004 54            	srlw	x
 577  0005 54            	srlw	x
 578  0006 54            	srlw	x
 579  0007 9f            	ld	a,xl
 580  0008 a40f          	and	a,#15
 581  000a 6b05          	ld	(OFST-3,sp),a
 583                     ; 238         d2 = (n>>8)  & 0xF;
 585  000c 7b09          	ld	a,(OFST+1,sp)
 586  000e a40f          	and	a,#15
 587  0010 6b07          	ld	(OFST-1,sp),a
 589                     ; 239         d3 = (n>>12) & 0xF;
 591  0012 1e09          	ldw	x,(OFST+1,sp)
 592  0014 01            	rrwa	x,a
 593  0015 9f            	ld	a,xl
 594  0016 4e            	swap	a
 595  0017 a40f          	and	a,#15
 596  0019 6b06          	ld	(OFST-2,sp),a
 598                     ; 241         d0 = 6*(d3 + d2 + d1) + (n & 0xF);
 600  001b 7b0a          	ld	a,(OFST+2,sp)
 601  001d a40f          	and	a,#15
 602  001f 6b01          	ld	(OFST-7,sp),a
 604  0021 7b06          	ld	a,(OFST-2,sp)
 605  0023 1b07          	add	a,(OFST-1,sp)
 606  0025 1b05          	add	a,(OFST-3,sp)
 607  0027 97            	ld	xl,a
 608  0028 a606          	ld	a,#6
 609  002a 42            	mul	x,a
 610  002b 9f            	ld	a,xl
 611  002c 1b01          	add	a,(OFST-7,sp)
 612  002e 6b02          	ld	(OFST-6,sp),a
 614                     ; 242         q = (d0 * 0xCD) >> 11;
 616  0030 97            	ld	xl,a
 617  0031 a6cd          	ld	a,#205
 618  0033 42            	mul	x,a
 619  0034 4f            	clr	a
 620  0035 5d            	tnzw	x
 621  0036 2a01          	jrpl	L02
 622  0038 43            	cpl	a
 623  0039               L02:
 624  0039 97            	ld	xl,a
 625  003a 5e            	swapw	x
 626  003b 57            	sraw	x
 627  003c 57            	sraw	x
 628  003d 57            	sraw	x
 629  003e 01            	rrwa	x,a
 630  003f 6b08          	ld	(OFST+0,sp),a
 632                     ; 243         d0 = d0 - 10*q;
 634  0041 cd00d8        	call	LC004
 635  0044 1002          	sub	a,(OFST-6,sp)
 636  0046 40            	neg	a
 637  0047 6b02          	ld	(OFST-6,sp),a
 639                     ; 245         d1 = q + 9*d3 + 5*d2 + d1;
 641  0049 7b07          	ld	a,(OFST-1,sp)
 642  004b 97            	ld	xl,a
 643  004c a605          	ld	a,#5
 644  004e 42            	mul	x,a
 645  004f 9f            	ld	a,xl
 646  0050 6b01          	ld	(OFST-7,sp),a
 648  0052 7b06          	ld	a,(OFST-2,sp)
 649  0054 97            	ld	xl,a
 650  0055 a609          	ld	a,#9
 651  0057 42            	mul	x,a
 652  0058 9f            	ld	a,xl
 653  0059 1b08          	add	a,(OFST+0,sp)
 654  005b 1b01          	add	a,(OFST-7,sp)
 655  005d 1b05          	add	a,(OFST-3,sp)
 656  005f 6b05          	ld	(OFST-3,sp),a
 658                     ; 246         q = (d1 * 0xCD) >> 11;
 660  0061 97            	ld	xl,a
 661  0062 a6cd          	ld	a,#205
 662  0064 42            	mul	x,a
 663  0065 4f            	clr	a
 664  0066 5d            	tnzw	x
 665  0067 2a01          	jrpl	L22
 666  0069 43            	cpl	a
 667  006a               L22:
 668  006a 97            	ld	xl,a
 669  006b 5e            	swapw	x
 670  006c 57            	sraw	x
 671  006d 57            	sraw	x
 672  006e 57            	sraw	x
 673  006f 01            	rrwa	x,a
 674  0070 6b08          	ld	(OFST+0,sp),a
 676                     ; 247         d1 = d1 - 10*q;
 678  0072 ad64          	call	LC004
 679  0074 1005          	sub	a,(OFST-3,sp)
 680  0076 40            	neg	a
 681  0077 6b05          	ld	(OFST-3,sp),a
 683                     ; 249         d2 = q + 2*d2;
 685  0079 7b07          	ld	a,(OFST-1,sp)
 686  007b 48            	sll	a
 687  007c 1b08          	add	a,(OFST+0,sp)
 688  007e 6b07          	ld	(OFST-1,sp),a
 690                     ; 250         q = (d2 * 0x1A) >> 8;
 692  0080 97            	ld	xl,a
 693  0081 a61a          	ld	a,#26
 694  0083 42            	mul	x,a
 695  0084 4f            	clr	a
 696  0085 5d            	tnzw	x
 697  0086 2a01          	jrpl	L42
 698  0088 43            	cpl	a
 699  0089               L42:
 700  0089 97            	ld	xl,a
 701  008a 5e            	swapw	x
 702  008b 01            	rrwa	x,a
 703  008c 6b08          	ld	(OFST+0,sp),a
 705                     ; 251         d2 = d2 - 10*q;
 707  008e ad48          	call	LC004
 708  0090 1007          	sub	a,(OFST-1,sp)
 709  0092 40            	neg	a
 710  0093 6b07          	ld	(OFST-1,sp),a
 712                     ; 253         d3 = q + 4*d3;
 714  0095 7b06          	ld	a,(OFST-2,sp)
 715  0097 48            	sll	a
 716  0098 48            	sll	a
 717  0099 1b08          	add	a,(OFST+0,sp)
 718  009b 6b06          	ld	(OFST-2,sp),a
 720                     ; 254         d4 = (d3 * 0x1A) >> 8;
 722  009d 97            	ld	xl,a
 723  009e a61a          	ld	a,#26
 724  00a0 42            	mul	x,a
 725  00a1 4f            	clr	a
 726  00a2 5d            	tnzw	x
 727  00a3 2a01          	jrpl	L62
 728  00a5 43            	cpl	a
 729  00a6               L62:
 730  00a6 97            	ld	xl,a
 731  00a7 5e            	swapw	x
 732  00a8 01            	rrwa	x,a
 733  00a9 6b08          	ld	(OFST+0,sp),a
 735                     ; 255         d3 = d3 - 10*d4;
 737  00ab ad2b          	call	LC004
 738  00ad 1006          	sub	a,(OFST-2,sp)
 739  00af 40            	neg	a
 740  00b0 6b06          	ld	(OFST-2,sp),a
 742                     ; 257 				ptr = buffer;
 745                     ; 258     *ptr++ = ( d4 + '0' );
 747  00b2 7b08          	ld	a,(OFST+0,sp)
 748  00b4 1e0d          	ldw	x,(OFST+5,sp)
 749  00b6 ad26          	call	LC005
 750                     ; 259     *ptr++ = ( d3 + '0' );
 752  00b8 7b06          	ld	a,(OFST-2,sp)
 753  00ba ad22          	call	LC005
 754                     ; 260     *ptr++ = ( d2 + '0' );
 756  00bc 7b07          	ld	a,(OFST-1,sp)
 757  00be ad1e          	call	LC005
 758                     ; 261     *ptr++ = ( d1 + '0' );
 760  00c0 7b05          	ld	a,(OFST-3,sp)
 761  00c2 ad1a          	call	LC005
 762                     ; 262     *ptr++ = ( d0 + '0' );
 764  00c4 7b02          	ld	a,(OFST-6,sp)
 765  00c6 ad16          	call	LC005
 766  00c8 1f03          	ldw	(OFST-5,sp),x
 767                     ; 263         *ptr = 0;
 769  00ca 7f            	clr	(x)
 771  00cb 1e0d          	ldw	x,(OFST+5,sp)
 772  00cd 2001          	jra	L774
 773  00cf               L374:
 774                     ; 265         while(buffer[0] == '0') ++buffer;
 776  00cf 5c            	incw	x
 777  00d0               L774:
 780  00d0 f6            	ld	a,(x)
 781  00d1 a130          	cp	a,#48
 782  00d3 27fa          	jreq	L374
 783                     ; 266         return buffer;
 787  00d5 5b0a          	addw	sp,#10
 788  00d7 81            	ret	
 789  00d8               LC004:
 790  00d8 97            	ld	xl,a
 791  00d9 a60a          	ld	a,#10
 792  00db 42            	mul	x,a
 793  00dc 9f            	ld	a,xl
 794  00dd 81            	ret	
 795  00de               LC005:
 796  00de ab30          	add	a,#48
 798  00e0 f7            	ld	(x),a
 799  00e1 5c            	incw	x
 800  00e2 81            	ret	
 875                     	switch	.const
 876  0070               L23:
 877  0070 000003e8      	dc.l	1000
 878                     ; 270 int I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte, int nostop)
 878                     ; 271 {
 879                     .text:	section	.text,new
 880  0000               _I2C_writenbyte:
 882  0000 88            	push	a
 883  0001 5204          	subw	sp,#4
 884       00000004      OFST:	set	4
 887                     ; 273 	timeout = current_millis + 1000;
 889  0003 ae0024        	ldw	x,#_current_millis
 890  0006 cd0000        	call	c_ltor
 892  0009 ae0070        	ldw	x,#L23
 893  000c cd0000        	call	c_ladd
 895  000f 96            	ldw	x,sp
 896  0010 5c            	incw	x
 897  0011 cd0000        	call	c_rtol
 901  0014 200d          	jra	L545
 902  0016               L145:
 903                     ; 277 		if (current_millis>timeout) return 0;
 905  0016 ae0024        	ldw	x,#_current_millis
 906  0019 cd0000        	call	c_ltor
 908  001c 96            	ldw	x,sp
 909  001d 5c            	incw	x
 910  001e cd0000        	call	c_lcmp
 914  0021 221c          	jrugt	LC006
 915  0023               L545:
 916                     ; 275 	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
 918  0023 ae0302        	ldw	x,#770
 919  0026 cd0000        	call	_I2C_GetFlagStatus
 921  0029 4d            	tnz	a
 922  002a 26ea          	jrne	L145
 923                     ; 280 	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
 925  002c 72105211      	bset	21009,#0
 927  0030 2011          	jra	L555
 928  0032               L355:
 929                     ; 283 		if (current_millis>timeout) return 0;
 931  0032 ae0024        	ldw	x,#_current_millis
 932  0035 cd0000        	call	c_ltor
 934  0038 96            	ldw	x,sp
 935  0039 5c            	incw	x
 936  003a cd0000        	call	c_lcmp
 938  003d 2304          	jrule	L555
 941  003f               LC006:
 945  003f 5f            	clrw	x
 947  0040               L64:
 949  0040 5b05          	addw	sp,#5
 950  0042 81            	ret	
 951  0043               L555:
 952                     ; 281 	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
 954  0043 ae0301        	ldw	x,#769
 955  0046 cd0000        	call	_I2C_CheckEvent
 957  0049 4d            	tnz	a
 958  004a 27e6          	jreq	L355
 959                     ; 286   I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_TX);
 961  004c 7b05          	ld	a,(OFST+1,sp)
 962  004e 48            	sll	a
 963  004f 5f            	clrw	x
 964  0050 95            	ld	xh,a
 965  0051 cd0000        	call	_I2C_Send7bitAddress
 968  0054 200d          	jra	L565
 969  0056               L365:
 970                     ; 289 		if (current_millis>timeout) return 0;
 972  0056 ae0024        	ldw	x,#_current_millis
 973  0059 cd0000        	call	c_ltor
 975  005c 96            	ldw	x,sp
 976  005d 5c            	incw	x
 977  005e cd0000        	call	c_lcmp
 981  0061 22dc          	jrugt	LC006
 982  0063               L565:
 983                     ; 287 	while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
 985  0063 ae0782        	ldw	x,#1922
 986  0066 cd0000        	call	_I2C_CheckEvent
 988  0069 4d            	tnz	a
 989  006a 27ea          	jreq	L365
 991  006c 2028          	jra	L575
 992  006e               L375:
 993                     ; 294 		I2C->DR = (uint8_t)*buff;//I2C_SendData((uint8_t)*buff);//ctrl meas
 995  006e 1e08          	ldw	x,(OFST+4,sp)
 996  0070 f6            	ld	a,(x)
 997  0071 c75216        	ld	21014,a
 999  0074 200d          	jra	L506
1000  0076               L106:
1001                     ; 297 			if (current_millis>timeout) return 0;
1003  0076 ae0024        	ldw	x,#_current_millis
1004  0079 cd0000        	call	c_ltor
1006  007c 96            	ldw	x,sp
1007  007d 5c            	incw	x
1008  007e cd0000        	call	c_lcmp
1012  0081 22bc          	jrugt	LC006
1013  0083               L506:
1014                     ; 295 		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
1016  0083 ae0104        	ldw	x,#260
1017  0086 cd0000        	call	_I2C_GetFlagStatus
1019  0089 4d            	tnz	a
1020  008a 27ea          	jreq	L106
1021                     ; 299 		*buff++;
1023  008c 1e08          	ldw	x,(OFST+4,sp)
1024  008e 5c            	incw	x
1025  008f 1f08          	ldw	(OFST+4,sp),x
1026                     ; 300 		nbyte--;
1028  0091 1e0a          	ldw	x,(OFST+6,sp)
1029  0093 5a            	decw	x
1030  0094 1f0a          	ldw	(OFST+6,sp),x
1031  0096               L575:
1032                     ; 292 	while (nbyte>0)
1034  0096 9c            	rvf	
1035  0097 1e0a          	ldw	x,(OFST+6,sp)
1036  0099 2cd3          	jrsgt	L375
1037                     ; 303 	if(nostop==0) 
1039  009b 1e0c          	ldw	x,(OFST+8,sp)
1040  009d 2604          	jrne	L316
1041                     ; 305 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1043  009f 72125211      	bset	21009,#1
1044  00a3               L316:
1045                     ; 308 	return 1;
1047  00a3 ae0001        	ldw	x,#1
1049  00a6 2098          	jra	L64
1135                     ; 311 int I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte,int nocheckbusy)
1135                     ; 312 {
1136                     .text:	section	.text,new
1137  0000               _I2C_readnbyte:
1139  0000 88            	push	a
1140  0001 5204          	subw	sp,#4
1141       00000004      OFST:	set	4
1144                     ; 314 	timeout = current_millis + 1000;
1146  0003 ae0024        	ldw	x,#_current_millis
1147  0006 cd0000        	call	c_ltor
1149  0009 ae0070        	ldw	x,#L23
1150  000c cd0000        	call	c_ladd
1152  000f 96            	ldw	x,sp
1153  0010 5c            	incw	x
1154  0011 cd0000        	call	c_rtol
1157                     ; 316 	if (nocheckbusy==0) 
1159  0014 1e0c          	ldw	x,(OFST+8,sp)
1160  0016 2618          	jrne	L356
1162  0018 200d          	jra	L756
1163  001a               L556:
1164                     ; 320 			if (current_millis>timeout) return 0;
1166  001a ae0024        	ldw	x,#_current_millis
1167  001d cd0000        	call	c_ltor
1169  0020 96            	ldw	x,sp
1170  0021 5c            	incw	x
1171  0022 cd0000        	call	c_lcmp
1175  0025 221c          	jrugt	LC007
1176  0027               L756:
1177                     ; 318 		while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
1179  0027 ae0302        	ldw	x,#770
1180  002a cd0000        	call	_I2C_GetFlagStatus
1182  002d 4d            	tnz	a
1183  002e 26ea          	jrne	L556
1184  0030               L356:
1185                     ; 324 	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
1187  0030 72105211      	bset	21009,#0
1189  0034 2011          	jra	L766
1190  0036               L566:
1191                     ; 327 		if (current_millis>timeout) return 0;
1193  0036 ae0024        	ldw	x,#_current_millis
1194  0039 cd0000        	call	c_ltor
1196  003c 96            	ldw	x,sp
1197  003d 5c            	incw	x
1198  003e cd0000        	call	c_lcmp
1200  0041 2304          	jrule	L766
1203  0043               LC007:
1216  0043 5f            	clrw	x
1218  0044               L411:
1220  0044 5b05          	addw	sp,#5
1221  0046 81            	ret	
1222  0047               L766:
1223                     ; 325 	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
1225  0047 ae0301        	ldw	x,#769
1226  004a cd0000        	call	_I2C_CheckEvent
1228  004d 4d            	tnz	a
1229  004e 27e6          	jreq	L566
1230                     ; 330 	I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_RX);
1232  0050 7b05          	ld	a,(OFST+1,sp)
1233  0052 48            	sll	a
1234  0053 ae0001        	ldw	x,#1
1235  0056 95            	ld	xh,a
1236  0057 cd0000        	call	_I2C_Send7bitAddress
1238                     ; 332 	if (nbyte >= 3) 
1240  005a 1e0a          	ldw	x,(OFST+6,sp)
1241  005c a30003        	cpw	x,#3
1242  005f 2e03cc0116    	jrslt	L576
1244  0064 200d          	jra	L107
1245  0066               L776:
1246                     ; 337 			if (current_millis>timeout) return 0;
1248  0066 ae0024        	ldw	x,#_current_millis
1249  0069 cd0000        	call	c_ltor
1251  006c 96            	ldw	x,sp
1252  006d 5c            	incw	x
1253  006e cd0000        	call	c_lcmp
1257  0071 22d0          	jrugt	LC007
1258  0073               L107:
1259                     ; 335 		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
1261  0073 cd01ec        	call	LC008
1262  0076 27ee          	jreq	L776
1263                     ; 339 		disableInterrupts();
1266  0078 9b            	sim	
1268                     ; 340 		(void)I2C->SR3;
1271  0079 c65219        	ld	a,21017
1272                     ; 341 		enableInterrupts();
1275  007c 9a            	rim	
1279  007d 1e0a          	ldw	x,(OFST+6,sp)
1280  007f 2020          	jra	L117
1281  0081               L517:
1282                     ; 347 				if (current_millis>timeout) return 0;
1284  0081 ae0024        	ldw	x,#_current_millis
1285  0084 cd0000        	call	c_ltor
1287  0087 96            	ldw	x,sp
1288  0088 5c            	incw	x
1289  0089 cd0000        	call	c_lcmp
1293  008c 22b5          	jrugt	LC007
1294  008e               L717:
1295                     ; 345 			while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
1297  008e cd01f4        	call	LC009
1298  0091 27ee          	jreq	L517
1299                     ; 350 			*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1301  0093 1e08          	ldw	x,(OFST+4,sp)
1302  0095 c65216        	ld	a,21014
1303  0098 f7            	ld	(x),a
1304                     ; 351 			*buff++;
1306  0099 5c            	incw	x
1307  009a 1f08          	ldw	(OFST+4,sp),x
1308                     ; 352 			nbyte--;
1310  009c 1e0a          	ldw	x,(OFST+6,sp)
1311  009e 5a            	decw	x
1312  009f 1f0a          	ldw	(OFST+6,sp),x
1313  00a1               L117:
1314                     ; 343 		while  (nbyte > 3) {
1316  00a1 a30004        	cpw	x,#4
1317  00a4 2ee8          	jrsge	L717
1319  00a6 200d          	jra	L727
1320  00a8               L527:
1321                     ; 359 			if (current_millis>timeout) return 0;
1323  00a8 ae0024        	ldw	x,#_current_millis
1324  00ab cd0000        	call	c_ltor
1326  00ae 96            	ldw	x,sp
1327  00af 5c            	incw	x
1328  00b0 cd0000        	call	c_lcmp
1332  00b3 228e          	jrugt	LC007
1333  00b5               L727:
1334                     ; 357 		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
1336  00b5 cd01f4        	call	LC009
1337  00b8 27ee          	jreq	L527
1338                     ; 362 		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);
1340  00ba 72155211      	bres	21009,#2
1341                     ; 363 		disableInterrupts();
1344  00be 9b            	sim	
1346                     ; 364 		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1349  00bf 1e08          	ldw	x,(OFST+4,sp)
1350  00c1 c65216        	ld	a,21014
1351  00c4 f7            	ld	(x),a
1352                     ; 365 		*buff++;
1354  00c5 5c            	incw	x
1355  00c6 1f08          	ldw	(OFST+4,sp),x
1356                     ; 366 		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1358  00c8 72125211      	bset	21009,#1
1359                     ; 367 		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1361  00cc c65216        	ld	a,21014
1362  00cf f7            	ld	(x),a
1363                     ; 368 		enableInterrupts();
1366  00d0 9a            	rim	
1368                     ; 369 		*buff++;
1371  00d1 5c            	incw	x
1372  00d2 1f08          	ldw	(OFST+4,sp),x
1374  00d4 2010          	jra	L737
1375  00d6               L537:
1376                     ; 372 			if (current_millis>timeout) return 0;
1378  00d6 ae0024        	ldw	x,#_current_millis
1379  00d9 cd0000        	call	c_ltor
1381  00dc 96            	ldw	x,sp
1382  00dd 5c            	incw	x
1383  00de cd0000        	call	c_lcmp
1387  00e1 2303cc0043    	jrugt	LC007
1388  00e6               L737:
1389                     ; 370 		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
1391  00e6 ae0140        	ldw	x,#320
1392  00e9 cd0000        	call	_I2C_GetFlagStatus
1394  00ec 4d            	tnz	a
1395  00ed 27e7          	jreq	L537
1396                     ; 375 		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();	
1398  00ef 1e08          	ldw	x,(OFST+4,sp)
1399  00f1 c65216        	ld	a,21014
1400  00f4 f7            	ld	(x),a
1401                     ; 376 		 nbyte=0;
1403  00f5 5f            	clrw	x
1404  00f6 1f0a          	ldw	(OFST+6,sp),x
1406  00f8 200d          	jra	L157
1407  00fa               L547:
1408                     ; 380 			if (current_millis>timeout) return 0;
1410  00fa ae0024        	ldw	x,#_current_millis
1411  00fd cd0000        	call	c_ltor
1413  0100 96            	ldw	x,sp
1414  0101 5c            	incw	x
1415  0102 cd0000        	call	c_lcmp
1419  0105 22dc          	jrugt	LC007
1420  0107               L157:
1421                     ; 378 		while(I2C->CR2 & I2C_CR2_STOP)
1423  0107 72025211ee    	btjt	21009,#1,L547
1424                     ; 385     I2C->CR2 |= I2C_CR2_ACK;
1426  010c 72145211      	bset	21009,#2
1427                     ; 386 		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
1429  0110 72175211      	bres	21009,#3
1430  0114 1e0a          	ldw	x,(OFST+6,sp)
1431  0116               L576:
1432                     ; 391 	if (nbyte == 2) 
1434  0116 a30002        	cpw	x,#2
1435  0119 266b          	jrne	L757
1436                     ; 393 		I2C_AcknowledgeConfig(I2C_ACK_NEXT);
1438  011b a602          	ld	a,#2
1439  011d cd0000        	call	_I2C_AcknowledgeConfig
1442  0120 200d          	jra	L367
1443  0122               L167:
1444                     ; 397 			if (current_millis>timeout) return 0;
1446  0122 ae0024        	ldw	x,#_current_millis
1447  0125 cd0000        	call	c_ltor
1449  0128 96            	ldw	x,sp
1450  0129 5c            	incw	x
1451  012a cd0000        	call	c_lcmp
1455  012d 22b4          	jrugt	LC007
1456  012f               L367:
1457                     ; 395 		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
1459  012f cd01ec        	call	LC008
1460  0132 27ee          	jreq	L167
1461                     ; 399 		(void)I2C->SR3;
1463  0134 c65219        	ld	a,21017
1464                     ; 400 		I2C_AcknowledgeConfig(I2C_ACK_NONE);
1466  0137 4f            	clr	a
1467  0138 cd0000        	call	_I2C_AcknowledgeConfig
1470  013b 200d          	jra	L377
1471  013d               L177:
1472                     ; 404 			if (current_millis>timeout) return 0;
1474  013d ae0024        	ldw	x,#_current_millis
1475  0140 cd0000        	call	c_ltor
1477  0143 96            	ldw	x,sp
1478  0144 5c            	incw	x
1479  0145 cd0000        	call	c_lcmp
1483  0148 2299          	jrugt	LC007
1484  014a               L377:
1485                     ; 402 		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
1487  014a cd01f4        	call	LC009
1488  014d 27ee          	jreq	L177
1489                     ; 407 		disableInterrupts();
1492  014f 9b            	sim	
1494                     ; 408 		I2C_GenerateSTOP(ENABLE);
1497  0150 a601          	ld	a,#1
1498  0152 cd0000        	call	_I2C_GenerateSTOP
1500                     ; 409 		*buff= I2C_ReceiveData();
1502  0155 cd0000        	call	_I2C_ReceiveData
1504  0158 1e08          	ldw	x,(OFST+4,sp)
1505  015a f7            	ld	(x),a
1506                     ; 410 		enableInterrupts();
1509  015b 9a            	rim	
1511                     ; 412 		*buff++;  
1514  015c 5c            	incw	x
1515  015d 1f08          	ldw	(OFST+4,sp),x
1516                     ; 413 		*buff= I2C_ReceiveData();
1518  015f cd0000        	call	_I2C_ReceiveData
1520  0162 1e08          	ldw	x,(OFST+4,sp)
1521  0164 f7            	ld	(x),a
1522                     ; 414 		nbyte=0; 
1524  0165 5f            	clrw	x
1525  0166 1f0a          	ldw	(OFST+6,sp),x
1527  0168 2010          	jra	L5001
1528  016a               L1001:
1529                     ; 418 			if (current_millis>timeout) return 0;
1531  016a ae0024        	ldw	x,#_current_millis
1532  016d cd0000        	call	c_ltor
1534  0170 96            	ldw	x,sp
1535  0171 5c            	incw	x
1536  0172 cd0000        	call	c_lcmp
1540  0175 2303cc0043    	jrugt	LC007
1541  017a               L5001:
1542                     ; 416 		while(I2C->CR2 & I2C_CR2_STOP)
1544  017a 72025211eb    	btjt	21009,#1,L1001
1545                     ; 423     I2C_AcknowledgeConfig( I2C_ACK_CURR);
1547  017f a601          	ld	a,#1
1548  0181 cd0000        	call	_I2C_AcknowledgeConfig
1550  0184 1e0a          	ldw	x,(OFST+6,sp)
1551  0186               L757:
1552                     ; 427 	if (nbyte == 1) 
1554  0186 5a            	decw	x
1555  0187 265d          	jrne	L3101
1556                     ; 429 		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);   
1558  0189 72155211      	bres	21009,#2
1560  018d 200d          	jra	L7101
1561  018f               L5101:
1562                     ; 433 			if (current_millis>timeout) return 0;
1564  018f ae0024        	ldw	x,#_current_millis
1565  0192 cd0000        	call	c_ltor
1567  0195 96            	ldw	x,sp
1568  0196 5c            	incw	x
1569  0197 cd0000        	call	c_lcmp
1573  019a 22db          	jrugt	LC007
1574  019c               L7101:
1575                     ; 431 		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
1577  019c ad4e          	call	LC008
1578  019e 27ef          	jreq	L5101
1579                     ; 436 		disableInterrupts();
1582  01a0 9b            	sim	
1584                     ; 439     (void)I2C->SR3;
1587  01a1 c65219        	ld	a,21017
1588                     ; 442     I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP( ENABLE);
1590  01a4 72125211      	bset	21009,#1
1591                     ; 445     enableInterrupts();
1594  01a8 9a            	rim	
1598  01a9 200d          	jra	L7201
1599  01ab               L5201:
1600                     ; 450 			if (current_millis>timeout) return 0;
1602  01ab ae0024        	ldw	x,#_current_millis
1603  01ae cd0000        	call	c_ltor
1605  01b1 96            	ldw	x,sp
1606  01b2 5c            	incw	x
1607  01b3 cd0000        	call	c_lcmp
1611  01b6 22bf          	jrugt	LC007
1612  01b8               L7201:
1613                     ; 448     while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
1615  01b8 ae0140        	ldw	x,#320
1616  01bb cd0000        	call	_I2C_GetFlagStatus
1618  01be 4d            	tnz	a
1619  01bf 27ea          	jreq	L5201
1620                     ; 455     *buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
1622  01c1 1e08          	ldw	x,(OFST+4,sp)
1623  01c3 c65216        	ld	a,21014
1624  01c6 f7            	ld	(x),a
1625                     ; 458 		nbyte=0;
1627  01c7 5f            	clrw	x
1628  01c8 1f0a          	ldw	(OFST+6,sp),x
1630  01ca 200d          	jra	L1401
1631  01cc               L5301:
1632                     ; 463 			if (current_millis>timeout) return 0;
1634  01cc ae0024        	ldw	x,#_current_millis
1635  01cf cd0000        	call	c_ltor
1637  01d2 96            	ldw	x,sp
1638  01d3 5c            	incw	x
1639  01d4 cd0000        	call	c_lcmp
1643  01d7 229e          	jrugt	LC007
1644  01d9               L1401:
1645                     ; 461     while(I2C->CR2 & I2C_CR2_STOP)
1647  01d9 72025211ee    	btjt	21009,#1,L5301
1648                     ; 468     I2C->CR2 |= I2C_CR2_ACK;
1650  01de 72145211      	bset	21009,#2
1651                     ; 469 		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
1653  01e2 72175211      	bres	21009,#3
1654  01e6               L3101:
1655                     ; 472 	return 1;
1657  01e6 ae0001        	ldw	x,#1
1659  01e9 cc0044        	jra	L411
1660  01ec               LC008:
1661  01ec ae0102        	ldw	x,#258
1662  01ef cd0000        	call	_I2C_GetFlagStatus
1664  01f2 4d            	tnz	a
1665  01f3 81            	ret	
1666  01f4               LC009:
1667  01f4 ae0104        	ldw	x,#260
1668  01f7 cd0000        	call	_I2C_GetFlagStatus
1670  01fa 4d            	tnz	a
1671  01fb 81            	ret	
1696                     ; 475 int nctinit(void)
1696                     ; 476 {
1697                     .text:	section	.text,new
1698  0000               _nctinit:
1702                     ; 479 		buff[0] = (uint8_t) 0b1;
1704  0000 35010009      	mov	_buff,#1
1705                     ; 480 		buff[1] = (uint8_t) 0b0;//config reg
1707  0004 3f0a          	clr	_buff+1
1708                     ; 481 		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 1,0) ) 
1710  0006 5f            	clrw	x
1711  0007 89            	pushw	x
1712  0008 5c            	incw	x
1713  0009 89            	pushw	x
1714  000a ae0009        	ldw	x,#_buff
1715  000d 89            	pushw	x
1716  000e a648          	ld	a,#72
1717  0010 cd0000        	call	_I2C_writenbyte
1719  0013 5b06          	addw	sp,#6
1720  0015 5d            	tnzw	x
1721  0016 2606          	jrne	L7501
1722                     ; 483 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1724  0018 72125211      	bset	21009,#1
1725                     ; 484 			return 0;
1727  001c 5f            	clrw	x
1730  001d 81            	ret	
1731  001e               L7501:
1732                     ; 488 		return 1;
1735  001e ae0001        	ldw	x,#1
1738  0021 81            	ret	
1777                     	switch	.const
1778  0074               L231:
1779  0074 00000271      	dc.l	625
1780  0078               L431:
1781  0078 00000064      	dc.l	100
1782                     ; 491 int nctdata(void)
1782                     ; 492 {
1783                     .text:	section	.text,new
1784  0000               _nctdata:
1786  0000 5208          	subw	sp,#8
1787       00000008      OFST:	set	8
1790                     ; 495 		buff[0] = (uint8_t) 0x00;
1792  0002 3f09          	clr	_buff
1793                     ; 496 		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 1,0) ) 
1795  0004 5f            	clrw	x
1796  0005 89            	pushw	x
1797  0006 5c            	incw	x
1798  0007 89            	pushw	x
1799  0008 ae0009        	ldw	x,#_buff
1800  000b 89            	pushw	x
1801  000c a648          	ld	a,#72
1802  000e cd0000        	call	_I2C_writenbyte
1804  0011 5b06          	addw	sp,#6
1805  0013 5d            	tnzw	x
1806  0014 2607          	jrne	L7701
1807                     ; 498 			I2C_GenerateSTOP(ENABLE);
1809  0016 a601          	ld	a,#1
1810  0018 cd0000        	call	_I2C_GenerateSTOP
1812                     ; 499 			return 0;
1814  001b 2014          	jp	LC010
1815  001d               L7701:
1816                     ; 502 		if (! I2C_readnbyte((uint8_t)NCTaddr, buff, 2,0) ) 
1819  001d 5f            	clrw	x
1820  001e 89            	pushw	x
1821  001f ae0002        	ldw	x,#2
1822  0022 89            	pushw	x
1823  0023 ae0009        	ldw	x,#_buff
1824  0026 89            	pushw	x
1825  0027 a648          	ld	a,#72
1826  0029 cd0000        	call	_I2C_readnbyte
1828  002c 5b06          	addw	sp,#6
1829  002e 5d            	tnzw	x
1830  002f 2604          	jrne	L1011
1831                     ; 504 			return 0;
1833  0031               LC010:
1835  0031 5f            	clrw	x
1837  0032               L631:
1839  0032 5b08          	addw	sp,#8
1840  0034 81            	ret	
1841  0035               L1011:
1842                     ; 507 		tmcpT = (u32) (buff[0]<<8) | buff[1];
1845  0035 450a03        	mov	c_lreg+3,_buff+1
1846  0038 3f02          	clr	c_lreg+2
1847  003a 3f01          	clr	c_lreg+1
1848  003c 3f00          	clr	c_lreg
1849  003e 96            	ldw	x,sp
1850  003f 5c            	incw	x
1851  0040 cd0000        	call	c_rtol
1854  0043 b609          	ld	a,_buff
1855  0045 97            	ld	xl,a
1856  0046 4f            	clr	a
1857  0047 02            	rlwa	x,a
1858  0048 cd0000        	call	c_itolx
1860  004b 96            	ldw	x,sp
1861  004c 5c            	incw	x
1862  004d cd0000        	call	c_lor
1864  0050 96            	ldw	x,sp
1865  0051 1c0005        	addw	x,#OFST-3
1866  0054 cd0000        	call	c_rtol
1869                     ; 508 		bmeT = (tmcpT>>4) * 625 / 100;
1871  0057 96            	ldw	x,sp
1872  0058 1c0005        	addw	x,#OFST-3
1873  005b cd0000        	call	c_ltor
1875  005e a604          	ld	a,#4
1876  0060 cd0000        	call	c_lrsh
1878  0063 ae0074        	ldw	x,#L231
1879  0066 cd0000        	call	c_lmul
1881  0069 ae0078        	ldw	x,#L431
1882  006c cd0000        	call	c_ldiv
1884  006f ae0001        	ldw	x,#_bmeT
1885  0072 cd0000        	call	c_rtol
1887                     ; 510 		return 1;
1889  0075 ae0001        	ldw	x,#1
1891  0078 20b8          	jra	L631
1916                     ; 514 int uvinit(void)
1916                     ; 515 {
1917                     .text:	section	.text,new
1918  0000               _uvinit:
1922                     ; 517 		buff[0] = (uint8_t) 0b0;//config reg
1924  0000 3f09          	clr	_buff
1925                     ; 518 		buff[1] = (uint8_t) 0b00100000;//low byte
1927  0002 3520000a      	mov	_buff+1,#32
1928                     ; 519 		buff[2] = (uint8_t) 0b0;//high byte
1930  0006 3f0b          	clr	_buff+2
1931                     ; 520 		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
1933  0008 5f            	clrw	x
1934  0009 89            	pushw	x
1935  000a ae0003        	ldw	x,#3
1936  000d 89            	pushw	x
1937  000e ae0009        	ldw	x,#_buff
1938  0011 89            	pushw	x
1939  0012 a610          	ld	a,#16
1940  0014 cd0000        	call	_I2C_writenbyte
1942  0017 5b06          	addw	sp,#6
1943  0019 5d            	tnzw	x
1944  001a 2606          	jrne	L3111
1945                     ; 522 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
1947  001c 72125211      	bset	21009,#1
1948                     ; 523 			return 0;
1950  0020 5f            	clrw	x
1953  0021 81            	ret	
1954  0022               L3111:
1955                     ; 528 		return 1;
1958  0022 ae0001        	ldw	x,#1
1961  0025 81            	ret	
1988                     ; 531 int uvdata(void)
1988                     ; 532 {
1989                     .text:	section	.text,new
1990  0000               _uvdata:
1994                     ; 537 		buff[0] = (uint8_t) 0x09;//uva
1996  0000 35090009      	mov	_buff,#9
1997                     ; 538 		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 1,1) ) 
1999  0004 ae0001        	ldw	x,#1
2000  0007 89            	pushw	x
2001  0008 89            	pushw	x
2002  0009 ae0009        	ldw	x,#_buff
2003  000c 89            	pushw	x
2004  000d a610          	ld	a,#16
2005  000f cd0000        	call	_I2C_writenbyte
2007  0012 5b06          	addw	sp,#6
2008  0014 5d            	tnzw	x
2009  0015 2607          	jrne	L5211
2010                     ; 540 			I2C_GenerateSTOP(ENABLE);
2012  0017 a601          	ld	a,#1
2013  0019 cd0000        	call	_I2C_GenerateSTOP
2015                     ; 541 			return 0;
2017  001c 5f            	clrw	x
2020  001d 81            	ret	
2021  001e               L5211:
2022                     ; 544 		if (! I2C_readnbyte((uint8_t)UVaddr, buff, 2,1) ) 
2025  001e ae0001        	ldw	x,#1
2026  0021 89            	pushw	x
2027  0022 5c            	incw	x
2028  0023 89            	pushw	x
2029  0024 ae0009        	ldw	x,#_buff
2030  0027 89            	pushw	x
2031  0028 a610          	ld	a,#16
2032  002a cd0000        	call	_I2C_readnbyte
2034  002d 5b06          	addw	sp,#6
2035  002f 5d            	tnzw	x
2036  0030 2602          	jrne	L7211
2037                     ; 546 			return 0;
2039  0032 5f            	clrw	x
2042  0033 81            	ret	
2043  0034               L7211:
2044                     ; 551 		return 1;
2047  0034 ae0001        	ldw	x,#1
2050  0037 81            	ret	
2102                     ; 555 double mypow(double a,int b) {
2103                     .text:	section	.text,new
2104  0000               _mypow:
2106  0000 5204          	subw	sp,#4
2107       00000004      OFST:	set	4
2110                     ; 558 		double x=a;
2112  0002 1e09          	ldw	x,(OFST+5,sp)
2113  0004 1f03          	ldw	(OFST-1,sp),x
2114  0006 1e07          	ldw	x,(OFST+3,sp)
2115  0008 1f01          	ldw	(OFST-3,sp),x
2117                     ; 559 		if (b==1) return a;
2119  000a 1e0b          	ldw	x,(OFST+7,sp)
2120  000c a30001        	cpw	x,#1
2121  000f 2613          	jrne	L3611
2124  0011 96            	ldw	x,sp
2125  0012 1c0007        	addw	x,#OFST+3
2128  0015 2016          	jra	L651
2129  0017               L1611:
2130                     ; 563 			x *= a;
2132  0017 1c0007        	addw	x,#OFST+3
2133  001a cd0000        	call	c_ltor
2135  001d 96            	ldw	x,sp
2136  001e 5c            	incw	x
2137  001f cd0000        	call	c_fgmul
2140  0022 1e0b          	ldw	x,(OFST+7,sp)
2141  0024               L3611:
2142                     ; 561 		while (b--) 
2144  0024 5a            	decw	x
2145  0025 1f0b          	ldw	(OFST+7,sp),x
2146  0027 96            	ldw	x,sp
2147  0028 26ed          	jrne	L1611
2148                     ; 566 		return x;
2150  002a 1c0001        	addw	x,#OFST-3
2153  002d               L651:
2154  002d cd0000        	call	c_ltor
2156  0030 5b04          	addw	sp,#4
2157  0032 81            	ret	
2182                     ; 569 int mcpinit(void)
2182                     ; 570 {
2183                     .text:	section	.text,new
2184  0000               _mcpinit:
2188                     ; 571 		buff[0] = (uint8_t) 0b00011111;
2190  0000 351f0009      	mov	_buff,#31
2191                     ; 572 		if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 2,0) ) 
2193  0004 5f            	clrw	x
2194  0005 89            	pushw	x
2195  0006 ae0002        	ldw	x,#2
2196  0009 89            	pushw	x
2197  000a ae0009        	ldw	x,#_buff
2198  000d 89            	pushw	x
2199  000e a668          	ld	a,#104
2200  0010 cd0000        	call	_I2C_writenbyte
2202  0013 5b06          	addw	sp,#6
2203  0015 5d            	tnzw	x
2204  0016 2606          	jrne	L7711
2205                     ; 574 			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
2207  0018 72125211      	bset	21009,#1
2208                     ; 575 			return 0;
2210  001c 5f            	clrw	x
2213  001d 81            	ret	
2214  001e               L7711:
2215                     ; 579 		return 1;
2218  001e ae0001        	ldw	x,#1
2221  0021 81            	ret	
2290                     ; 582 int mcpdata(void)
2290                     ; 583 {
2291                     .text:	section	.text,new
2292  0000               _mcpdata:
2294  0000 5212          	subw	sp,#18
2295       00000012      OFST:	set	18
2298                     ; 588 		if (! I2C_readnbyte((uint8_t)MCPaddr, buff, 4,0) ) return 0;		
2300  0002 5f            	clrw	x
2301  0003 89            	pushw	x
2302  0004 ae0004        	ldw	x,#4
2303  0007 89            	pushw	x
2304  0008 ae0009        	ldw	x,#_buff
2305  000b 89            	pushw	x
2306  000c a668          	ld	a,#104
2307  000e cd0000        	call	_I2C_readnbyte
2309  0011 5b06          	addw	sp,#6
2310  0013 5d            	tnzw	x
2313  0014 2772          	jreq	LC011
2314                     ; 590 		tmcpT = (int32_t) buff[0]<<16 | buff[1]<<8 | buff[2];
2316  0016 450b03        	mov	c_lreg+3,_buff+2
2317  0019 3f02          	clr	c_lreg+2
2318  001b 3f01          	clr	c_lreg+1
2319  001d 3f00          	clr	c_lreg
2320  001f 96            	ldw	x,sp
2321  0020 1c0005        	addw	x,#OFST-13
2322  0023 cd0000        	call	c_rtol
2325  0026 b60a          	ld	a,_buff+1
2326  0028 97            	ld	xl,a
2327  0029 4f            	clr	a
2328  002a 02            	rlwa	x,a
2329  002b cd0000        	call	c_itolx
2331  002e 96            	ldw	x,sp
2332  002f 5c            	incw	x
2333  0030 cd0000        	call	c_rtol
2336  0033 450903        	mov	c_lreg+3,_buff
2337  0036 3f02          	clr	c_lreg+2
2338  0038 3f01          	clr	c_lreg+1
2339  003a 3f00          	clr	c_lreg
2340  003c a610          	ld	a,#16
2341  003e cd0000        	call	c_llsh
2343  0041 96            	ldw	x,sp
2344  0042 5c            	incw	x
2345  0043 cd0000        	call	c_lor
2347  0046 96            	ldw	x,sp
2348  0047 1c0005        	addw	x,#OFST-13
2349  004a cd0000        	call	c_lor
2351  004d 96            	ldw	x,sp
2352  004e 1c000d        	addw	x,#OFST-5
2353  0051 cd0000        	call	c_rtol
2356                     ; 592 		e = (double) tmcpT/512; //* 15.625/8000;//в миливольтах
2358  0054 96            	ldw	x,sp
2359  0055 1c000d        	addw	x,#OFST-5
2360  0058 cd0000        	call	c_ltor
2362  005b cd0000        	call	c_ltof
2364  005e ae0080        	ldw	x,#L1421
2365  0061 cd0000        	call	c_fdiv
2367  0064 96            	ldw	x,sp
2368  0065 1c000d        	addw	x,#OFST-5
2369  0068 cd0000        	call	c_rtol
2372                     ; 594 		if (e <-5) return 0;	
2374  006b aefffb        	ldw	x,#65531
2375  006e cd0000        	call	c_itof
2377  0071 96            	ldw	x,sp
2378  0072 1c0005        	addw	x,#OFST-13
2379  0075 cd0000        	call	c_rtol
2382  0078 96            	ldw	x,sp
2383  0079 1c000d        	addw	x,#OFST-5
2384  007c cd0000        	call	c_ltor
2386  007f 96            	ldw	x,sp
2387  0080 1c0005        	addw	x,#OFST-13
2388  0083 cd0000        	call	c_fcmp
2390  0086 2e04          	jrsge	L5421
2393  0088               LC011:
2396  0088 5f            	clrw	x
2398  0089               L402:
2400  0089 5b12          	addw	sp,#18
2401  008b 81            	ret	
2402  008c               L5421:
2403                     ; 595 		if (e >30) return 0; //720gradusov
2405  008c a61e          	ld	a,#30
2406  008e cd0000        	call	c_ctof
2408  0091 96            	ldw	x,sp
2409  0092 1c0005        	addw	x,#OFST-13
2410  0095 cd0000        	call	c_rtol
2413  0098 96            	ldw	x,sp
2414  0099 1c000d        	addw	x,#OFST-5
2415  009c cd0000        	call	c_ltor
2417  009f 96            	ldw	x,sp
2418  00a0 1c0005        	addw	x,#OFST-13
2419  00a3 cd0000        	call	c_fcmp
2423  00a6 2ce0          	jrsgt	LC011
2424                     ; 597 		t=0;
2426  00a8 5f            	clrw	x
2427  00a9 1f0b          	ldw	(OFST-7,sp),x
2428  00ab 1f09          	ldw	(OFST-9,sp),x
2430                     ; 601 		if (e>20) 
2432  00ad a614          	ld	a,#20
2433  00af cd0000        	call	c_ctof
2435  00b2 96            	ldw	x,sp
2436  00b3 1c0005        	addw	x,#OFST-13
2437  00b6 cd0000        	call	c_rtol
2440  00b9 96            	ldw	x,sp
2441  00ba 1c000d        	addw	x,#OFST-5
2442  00bd cd0000        	call	c_ltor
2444  00c0 96            	ldw	x,sp
2445  00c1 1c0005        	addw	x,#OFST-13
2446  00c4 cd0000        	call	c_fcmp
2448  00c7 2d74          	jrsle	L1521
2449                     ; 603 			t=t+cKf[0];
2451  00c9 ce0046        	ldw	x,L712+2
2452  00cc 1f0b          	ldw	(OFST-7,sp),x
2453  00ce ce0044        	ldw	x,L712
2454  00d1 1f09          	ldw	(OFST-9,sp),x
2456                     ; 604 			for (i=0;i<6;i++) 
2458  00d3 5f            	clrw	x
2459  00d4 1f11          	ldw	(OFST-1,sp),x
2461  00d6               L3521:
2462                     ; 606 				t=t + (cKf[i+1])*mypow(e,(i+1));
2464  00d6 5c            	incw	x
2465  00d7 89            	pushw	x
2466  00d8 1e11          	ldw	x,(OFST-1,sp)
2467  00da 89            	pushw	x
2468  00db 1e11          	ldw	x,(OFST-1,sp)
2469  00dd 89            	pushw	x
2470  00de cd0000        	call	_mypow
2472  00e1 5b06          	addw	sp,#6
2473  00e3 96            	ldw	x,sp
2474  00e4 1c0005        	addw	x,#OFST-13
2475  00e7 cd0000        	call	c_rtol
2478  00ea 1e11          	ldw	x,(OFST-1,sp)
2479  00ec 58            	sllw	x
2480  00ed 58            	sllw	x
2481  00ee 1c0048        	addw	x,#_cKf+4
2482  00f1 cd0000        	call	c_ltor
2484  00f4 96            	ldw	x,sp
2485  00f5 1c0005        	addw	x,#OFST-13
2486  00f8 cd0000        	call	c_fmul
2488  00fb 96            	ldw	x,sp
2489  00fc 1c0009        	addw	x,#OFST-9
2490  00ff cd0000        	call	c_fgadd
2493                     ; 604 			for (i=0;i<6;i++) 
2495  0102 1e11          	ldw	x,(OFST-1,sp)
2496  0104 5c            	incw	x
2497  0105 1f11          	ldw	(OFST-1,sp),x
2501  0107 a30006        	cpw	x,#6
2502  010a 2fca          	jrslt	L3521
2504  010c               L1621:
2505                     ; 614 		t*=100;
2507  010c a664          	ld	a,#100
2508  010e cd0000        	call	c_ctof
2510  0111 96            	ldw	x,sp
2511  0112 1c0009        	addw	x,#OFST-9
2512  0115 cd0000        	call	c_fgmul
2515                     ; 615 		tmcpT = (long) t + bmeT;
2517  0118 96            	ldw	x,sp
2518  0119 1c0009        	addw	x,#OFST-9
2519  011c cd0000        	call	c_ltor
2521  011f cd0000        	call	c_ftol
2523  0122 ae0001        	ldw	x,#_bmeT
2524  0125 cd0000        	call	c_ladd
2526  0128 96            	ldw	x,sp
2527  0129 1c000d        	addw	x,#OFST-5
2528  012c cd0000        	call	c_rtol
2531                     ; 616 		mcpT = tmcpT;
2533  012f 1e0f          	ldw	x,(OFST-3,sp)
2534  0131 bf07          	ldw	_mcpT+2,x
2535  0133 1e0d          	ldw	x,(OFST-5,sp)
2536  0135 bf05          	ldw	_mcpT,x
2537                     ; 620 		return 1;
2539  0137 ae0001        	ldw	x,#1
2541  013a cc0089        	jra	L402
2542  013d               L1521:
2543                     ; 609 			for (i=0;i<((e>0)? 9 : 8);i++) 
2545  013d 5f            	clrw	x
2547  013e 203f          	jra	L7621
2548  0140               L3621:
2549                     ; 611 				t=t + ((e>0)?cK[i]:cKm[i])*mypow(e,i+1);
2551  0140 1e11          	ldw	x,(OFST-1,sp)
2552  0142 5c            	incw	x
2553  0143 89            	pushw	x
2554  0144 1e11          	ldw	x,(OFST-1,sp)
2555  0146 89            	pushw	x
2556  0147 1e11          	ldw	x,(OFST-1,sp)
2557  0149 89            	pushw	x
2558  014a cd0000        	call	_mypow
2560  014d 5b06          	addw	sp,#6
2561  014f 96            	ldw	x,sp
2562  0150 1c0005        	addw	x,#OFST-13
2563  0153 cd0000        	call	c_rtol
2566  0156 9c            	rvf	
2567  0157 7b0d          	ld	a,(OFST-5,sp)
2568  0159 2d09          	jrsle	L471
2569  015b 1e11          	ldw	x,(OFST-1,sp)
2570  015d 58            	sllw	x
2571  015e 58            	sllw	x
2572  015f 1c0000        	addw	x,#_cK
2574  0162 2007          	jra	L671
2575  0164               L471:
2576  0164 1e11          	ldw	x,(OFST-1,sp)
2577  0166 58            	sllw	x
2578  0167 58            	sllw	x
2579  0168 1c0024        	addw	x,#_cKm
2581  016b               L671:
2582  016b cd0000        	call	c_ltor
2583  016e 96            	ldw	x,sp
2584  016f 1c0005        	addw	x,#OFST-13
2585  0172 cd0000        	call	c_fmul
2587  0175 96            	ldw	x,sp
2588  0176 1c0009        	addw	x,#OFST-9
2589  0179 cd0000        	call	c_fgadd
2592                     ; 609 			for (i=0;i<((e>0)? 9 : 8);i++) 
2594  017c 1e11          	ldw	x,(OFST-1,sp)
2595  017e 5c            	incw	x
2596  017f               L7621:
2597  017f 1f11          	ldw	(OFST-1,sp),x
2601  0181 9c            	rvf	
2602  0182 7b0d          	ld	a,(OFST-5,sp)
2603  0184 2d05          	jrsle	L002
2604  0186 ae0009        	ldw	x,#9
2605  0189 2003          	jra	L202
2606  018b               L002:
2607  018b ae0008        	ldw	x,#8
2608  018e               L202:
2609  018e 1311          	cpw	x,(OFST-1,sp)
2610  0190 2cae          	jrsgt	L3621
2611  0192 cc010c        	jra	L1621
2647                     ; 624 void cifra(u8 num){
2648                     .text:	section	.text,new
2649  0000               _cifra:
2651  0000 88            	push	a
2652       00000000      OFST:	set	0
2655                     ; 625 	ALLOFF
2657  0001 4bc0          	push	#192
2658  0003 ae500a        	ldw	x,#20490
2659  0006 cd0000        	call	_GPIO_WriteHigh
2661  0009 84            	pop	a
2664  000a 4b2c          	push	#44
2665  000c ae500f        	ldw	x,#20495
2666  000f cd0000        	call	_GPIO_WriteHigh
2668  0012 84            	pop	a
2671  0013 4b06          	push	#6
2672  0015 ae5000        	ldw	x,#20480
2673  0018 cd0000        	call	_GPIO_WriteHigh
2675  001b 84            	pop	a
2676                     ; 627 	if (num==0) {
2678  001c 7b01          	ld	a,(OFST+1,sp)
2679  001e 260e          	jrne	L1131
2680                     ; 628 		AON;BON;CON;DON;EON;FON;
2682  0020 cd00aa        	call	LC012
2685  0023 cd00ae        	call	LC013
2688  0026 cd00da        	call	LC018
2691  0029 cd00c2        	call	LC015
2692  002c 7b01          	ld	a,(OFST+1,sp)
2693  002e               L1131:
2694                     ; 630 	if (num==1) {
2696  002e a101          	cp	a,#1
2697  0030 2605          	jrne	L3131
2698                     ; 631 		BON;CON;
2700  0032 cd00cc        	call	LC016
2701  0035 7b01          	ld	a,(OFST+1,sp)
2702  0037               L3131:
2703                     ; 633 	if (num==2) {
2705  0037 a102          	cp	a,#2
2706  0039 260f          	jrne	L5131
2707                     ; 634 		AON;BON;GON;EON;DON;
2709  003b cd00d0        	call	LC017
2712  003e cd00ee        	call	LC020
2715  0041 ad75          	call	LC014
2718  0043 cd00da        	call	LC018
2721  0046 ad66          	call	LC013
2722  0048 7b01          	ld	a,(OFST+1,sp)
2723  004a               L5131:
2724                     ; 636 	if (num==3) {
2726  004a a103          	cp	a,#3
2727  004c 2608          	jrne	L7131
2728                     ; 637 		AON;BON;CON;DON;GON;
2730  004e ad5a          	call	LC012
2733  0050 ad5c          	call	LC013
2736  0052 ad64          	call	LC014
2737  0054 7b01          	ld	a,(OFST+1,sp)
2738  0056               L7131:
2739                     ; 639 	if (num==4) {
2741  0056 a104          	cp	a,#4
2742  0058 2608          	jrne	L1231
2743                     ; 640 		FON;GON;BON;CON;
2745  005a ad66          	call	LC015
2748  005c ad5a          	call	LC014
2751  005e ad6c          	call	LC016
2752  0060 7b01          	ld	a,(OFST+1,sp)
2753  0062               L1231:
2754                     ; 642 	if (num==5) {
2756  0062 a105          	cp	a,#5
2757  0064 260c          	jrne	L3231
2758                     ; 643 		AON;FON;GON;CON;DON;
2760  0066 ad68          	call	LC017
2763  0068 ad58          	call	LC015
2766  006a ad4c          	call	LC014
2769  006c ad76          	call	LC019
2772  006e ad3e          	call	LC013
2773  0070 7b01          	ld	a,(OFST+1,sp)
2774  0072               L3231:
2775                     ; 645 	if (num==6) {
2777  0072 a106          	cp	a,#6
2778  0074 260e          	jrne	L5231
2779                     ; 646 		AON;EON;FON;GON;CON;DON;
2781  0076 ad58          	call	LC017
2784  0078 ad60          	call	LC018
2787  007a ad46          	call	LC015
2790  007c ad3a          	call	LC014
2793  007e ad64          	call	LC019
2796  0080 ad2c          	call	LC013
2797  0082 7b01          	ld	a,(OFST+1,sp)
2798  0084               L5231:
2799                     ; 648 	if (num==7) {
2801  0084 a107          	cp	a,#7
2802  0086 2604          	jrne	L7231
2803                     ; 649 		AON;BON;CON;
2805  0088 ad20          	call	LC012
2806  008a 7b01          	ld	a,(OFST+1,sp)
2807  008c               L7231:
2808                     ; 651 	if (num==8) {
2810  008c a108          	cp	a,#8
2811  008e 260c          	jrne	L1331
2812                     ; 652 		AON;BON;CON;GON;DON;EON;FON;
2814  0090 ad18          	call	LC012
2817  0092 ad24          	call	LC014
2820  0094 ad18          	call	LC013
2823  0096 ad42          	call	LC018
2826  0098 ad28          	call	LC015
2827  009a 7b01          	ld	a,(OFST+1,sp)
2828  009c               L1331:
2829                     ; 654 	if (num==9) {
2831  009c a109          	cp	a,#9
2832  009e 2608          	jrne	L3331
2833                     ; 655 		AON;BON;CON;GON;DON;FON;
2835  00a0 ad08          	call	LC012
2838  00a2 ad14          	call	LC014
2841  00a4 ad08          	call	LC013
2844  00a6 ad1a          	call	LC015
2845  00a8               L3331:
2846                     ; 658 }
2849  00a8 84            	pop	a
2850  00a9 81            	ret	
2851  00aa               LC012:
2852  00aa ad24          	call	LC017
2853                     ; 628 		AON;BON;CON;DON;EON;FON;
2855  00ac 201e          	jp	LC016
2856  00ae               LC013:
2857  00ae 4b80          	push	#128
2858  00b0 ae500a        	ldw	x,#20490
2859  00b3 cd0000        	call	_GPIO_WriteLow
2861  00b6 84            	pop	a
2862  00b7 81            	ret	
2863  00b8               LC014:
2864  00b8 4b08          	push	#8
2865  00ba ae500f        	ldw	x,#20495
2866  00bd cd0000        	call	_GPIO_WriteLow
2868  00c0 84            	pop	a
2869  00c1 81            	ret	
2870  00c2               LC015:
2871  00c2 4b02          	push	#2
2872  00c4 ae5000        	ldw	x,#20480
2873  00c7 cd0000        	call	_GPIO_WriteLow
2875  00ca 84            	pop	a
2876  00cb 81            	ret	
2877  00cc               LC016:
2878  00cc ad20          	call	LC020
2881  00ce 2014          	jp	LC019
2882  00d0               LC017:
2883  00d0 4b04          	push	#4
2884  00d2 ae5000        	ldw	x,#20480
2885  00d5 cd0000        	call	_GPIO_WriteLow
2887  00d8 84            	pop	a
2888  00d9 81            	ret	
2889  00da               LC018:
2890  00da 4b40          	push	#64
2891  00dc ae500a        	ldw	x,#20490
2892  00df cd0000        	call	_GPIO_WriteLow
2894  00e2 84            	pop	a
2895  00e3 81            	ret	
2896  00e4               LC019:
2897  00e4 4b04          	push	#4
2898  00e6 ae500f        	ldw	x,#20495
2899  00e9 cd0000        	call	_GPIO_WriteLow
2901  00ec 84            	pop	a
2902  00ed 81            	ret	
2903  00ee               LC020:
2904  00ee 4b20          	push	#32
2905  00f0 ae500f        	ldw	x,#20495
2906  00f3 cd0000        	call	_GPIO_WriteLow
2908  00f6 84            	pop	a
2909  00f7 81            	ret	
2973                     ; 661 void cifraS(u8 seg){
2974                     .text:	section	.text,new
2975  0000               _cifraS:
2977  0000 88            	push	a
2978  0001 5203          	subw	sp,#3
2979       00000003      OFST:	set	3
2982                     ; 662 	u8 j=0;
2984                     ; 664 	if(seg==0) AON;
2986  0003 4d            	tnz	a
2987  0004 2609          	jrne	L7631
2990  0006 4b04          	push	#4
2991  0008 ae5000        	ldw	x,#20480
2992  000b cd0000        	call	_GPIO_WriteLow
2994  000e 84            	pop	a
2995  000f               L7631:
2996                     ; 665 	if(seg==1) BON;
2998  000f 7b04          	ld	a,(OFST+1,sp)
2999  0011 a101          	cp	a,#1
3000  0013 260b          	jrne	L1731
3003  0015 4b20          	push	#32
3004  0017 ae500f        	ldw	x,#20495
3005  001a cd0000        	call	_GPIO_WriteLow
3007  001d 84            	pop	a
3008  001e 7b04          	ld	a,(OFST+1,sp)
3009  0020               L1731:
3010                     ; 666 	if(seg==2) CON;
3012  0020 a102          	cp	a,#2
3013  0022 260b          	jrne	L3731
3016  0024 4b04          	push	#4
3017  0026 ae500f        	ldw	x,#20495
3018  0029 cd0000        	call	_GPIO_WriteLow
3020  002c 84            	pop	a
3021  002d 7b04          	ld	a,(OFST+1,sp)
3022  002f               L3731:
3023                     ; 667 	if(seg==3) DON;
3025  002f a103          	cp	a,#3
3026  0031 260b          	jrne	L5731
3029  0033 4b80          	push	#128
3030  0035 ae500a        	ldw	x,#20490
3031  0038 cd0000        	call	_GPIO_WriteLow
3033  003b 84            	pop	a
3034  003c 7b04          	ld	a,(OFST+1,sp)
3035  003e               L5731:
3036                     ; 668 	if(seg==4) EON;
3038  003e a104          	cp	a,#4
3039  0040 260b          	jrne	L7731
3042  0042 4b40          	push	#64
3043  0044 ae500a        	ldw	x,#20490
3044  0047 cd0000        	call	_GPIO_WriteLow
3046  004a 84            	pop	a
3047  004b 7b04          	ld	a,(OFST+1,sp)
3048  004d               L7731:
3049                     ; 669 	if(seg==5) FON;
3051  004d a105          	cp	a,#5
3052  004f 260b          	jrne	L1041
3055  0051 4b02          	push	#2
3056  0053 ae5000        	ldw	x,#20480
3057  0056 cd0000        	call	_GPIO_WriteLow
3059  0059 84            	pop	a
3060  005a 7b04          	ld	a,(OFST+1,sp)
3061  005c               L1041:
3062                     ; 670 	if(seg==6) GON;
3064  005c a106          	cp	a,#6
3065  005e 2609          	jrne	L3041
3068  0060 4b08          	push	#8
3069  0062 ae500f        	ldw	x,#20495
3070  0065 cd0000        	call	_GPIO_WriteLow
3072  0068 84            	pop	a
3073  0069               L3041:
3074                     ; 672 	for (j=0;j<3;j++) {
3076  0069 0f03          	clr	(OFST+0,sp)
3078  006b               L5041:
3079                     ; 674 		u8 flag=0;
3081  006b 0f02          	clr	(OFST-1,sp)
3083                     ; 675 		num = ind[j];
3085  006d 5f            	clrw	x
3086  006e 7b03          	ld	a,(OFST+0,sp)
3087  0070 97            	ld	xl,a
3088  0071 e600          	ld	a,(_ind,x)
3089  0073 6b01          	ld	(OFST-2,sp),a
3091                     ; 678 		if (num==0) {
3093  0075 2639          	jrne	L3141
3094                     ; 680 			if(seg==0) flag=1;
3096  0077 0d04          	tnz	(OFST+1,sp)
3097  0079 2603          	jrne	L5141
3100  007b 4c            	inc	a
3101  007c 6b02          	ld	(OFST-1,sp),a
3103  007e               L5141:
3104                     ; 681 			if(seg==1) flag=1;
3106  007e 7b04          	ld	a,(OFST+1,sp)
3107  0080 a101          	cp	a,#1
3108  0082 2606          	jrne	L7141
3111  0084 a601          	ld	a,#1
3112  0086 6b02          	ld	(OFST-1,sp),a
3114  0088 7b04          	ld	a,(OFST+1,sp)
3115  008a               L7141:
3116                     ; 682 			if(seg==2)  flag=1;
3118  008a a102          	cp	a,#2
3119  008c 2606          	jrne	L1241
3122  008e a601          	ld	a,#1
3123  0090 6b02          	ld	(OFST-1,sp),a
3125  0092 7b04          	ld	a,(OFST+1,sp)
3126  0094               L1241:
3127                     ; 683 			if(seg==3)  flag=1;
3129  0094 a103          	cp	a,#3
3130  0096 2606          	jrne	L3241
3133  0098 a601          	ld	a,#1
3134  009a 6b02          	ld	(OFST-1,sp),a
3136  009c 7b04          	ld	a,(OFST+1,sp)
3137  009e               L3241:
3138                     ; 684 			if(seg==4)  flag=1;
3140  009e a104          	cp	a,#4
3141  00a0 2606          	jrne	L5241
3144  00a2 a601          	ld	a,#1
3145  00a4 6b02          	ld	(OFST-1,sp),a
3147  00a6 7b04          	ld	a,(OFST+1,sp)
3148  00a8               L5241:
3149                     ; 685 			if(seg==5)  flag=1;
3151  00a8 a105          	cp	a,#5
3152  00aa 2604          	jrne	L3141
3155  00ac a601          	ld	a,#1
3156  00ae 6b02          	ld	(OFST-1,sp),a
3158  00b0               L3141:
3159                     ; 687 		if (num==1) {
3161  00b0 7b01          	ld	a,(OFST-2,sp)
3162  00b2 4a            	dec	a
3163  00b3 2614          	jrne	L1341
3164                     ; 689 			if(seg==1) flag=1;
3166  00b5 7b04          	ld	a,(OFST+1,sp)
3167  00b7 a101          	cp	a,#1
3168  00b9 2606          	jrne	L3341
3171  00bb a601          	ld	a,#1
3172  00bd 6b02          	ld	(OFST-1,sp),a
3174  00bf 7b04          	ld	a,(OFST+1,sp)
3175  00c1               L3341:
3176                     ; 690 			if(seg==2)  flag=1;
3178  00c1 a102          	cp	a,#2
3179  00c3 2604          	jrne	L1341
3182  00c5 a601          	ld	a,#1
3183  00c7 6b02          	ld	(OFST-1,sp),a
3185  00c9               L1341:
3186                     ; 693 		if (num==2) {
3188  00c9 7b01          	ld	a,(OFST-2,sp)
3189  00cb a102          	cp	a,#2
3190  00cd 262f          	jrne	L7341
3191                     ; 695 			if(seg==0) flag=1;
3193  00cf 7b04          	ld	a,(OFST+1,sp)
3194  00d1 2605          	jrne	L1441
3197  00d3 4c            	inc	a
3198  00d4 6b02          	ld	(OFST-1,sp),a
3200  00d6 7b04          	ld	a,(OFST+1,sp)
3201  00d8               L1441:
3202                     ; 696 			if(seg==1) flag=1;
3204  00d8 a101          	cp	a,#1
3205  00da 2606          	jrne	L3441
3208  00dc a601          	ld	a,#1
3209  00de 6b02          	ld	(OFST-1,sp),a
3211  00e0 7b04          	ld	a,(OFST+1,sp)
3212  00e2               L3441:
3213                     ; 697 			if(seg==3)  flag=1;
3215  00e2 a103          	cp	a,#3
3216  00e4 2606          	jrne	L5441
3219  00e6 a601          	ld	a,#1
3220  00e8 6b02          	ld	(OFST-1,sp),a
3222  00ea 7b04          	ld	a,(OFST+1,sp)
3223  00ec               L5441:
3224                     ; 698 			if(seg==4)  flag=1;
3226  00ec a104          	cp	a,#4
3227  00ee 2606          	jrne	L7441
3230  00f0 a601          	ld	a,#1
3231  00f2 6b02          	ld	(OFST-1,sp),a
3233  00f4 7b04          	ld	a,(OFST+1,sp)
3234  00f6               L7441:
3235                     ; 699 			if(seg==6)  flag=1;
3237  00f6 a106          	cp	a,#6
3238  00f8 2604          	jrne	L7341
3241  00fa a601          	ld	a,#1
3242  00fc 6b02          	ld	(OFST-1,sp),a
3244  00fe               L7341:
3245                     ; 701 		if (num==3) {
3247  00fe 7b01          	ld	a,(OFST-2,sp)
3248  0100 a103          	cp	a,#3
3249  0102 262f          	jrne	L3541
3250                     ; 703 			if(seg==0) flag=1;
3252  0104 7b04          	ld	a,(OFST+1,sp)
3253  0106 2605          	jrne	L5541
3256  0108 4c            	inc	a
3257  0109 6b02          	ld	(OFST-1,sp),a
3259  010b 7b04          	ld	a,(OFST+1,sp)
3260  010d               L5541:
3261                     ; 704 			if(seg==1) flag=1;
3263  010d a101          	cp	a,#1
3264  010f 2606          	jrne	L7541
3267  0111 a601          	ld	a,#1
3268  0113 6b02          	ld	(OFST-1,sp),a
3270  0115 7b04          	ld	a,(OFST+1,sp)
3271  0117               L7541:
3272                     ; 705 			if(seg==2)  flag=1;
3274  0117 a102          	cp	a,#2
3275  0119 2606          	jrne	L1641
3278  011b a601          	ld	a,#1
3279  011d 6b02          	ld	(OFST-1,sp),a
3281  011f 7b04          	ld	a,(OFST+1,sp)
3282  0121               L1641:
3283                     ; 706 			if(seg==3)  flag=1;
3285  0121 a103          	cp	a,#3
3286  0123 2606          	jrne	L3641
3289  0125 a601          	ld	a,#1
3290  0127 6b02          	ld	(OFST-1,sp),a
3292  0129 7b04          	ld	a,(OFST+1,sp)
3293  012b               L3641:
3294                     ; 707 			if(seg==6)  flag=1;
3296  012b a106          	cp	a,#6
3297  012d 2604          	jrne	L3541
3300  012f a601          	ld	a,#1
3301  0131 6b02          	ld	(OFST-1,sp),a
3303  0133               L3541:
3304                     ; 709 		if (num==4) {
3306  0133 7b01          	ld	a,(OFST-2,sp)
3307  0135 a104          	cp	a,#4
3308  0137 2628          	jrne	L7641
3309                     ; 711 			if(seg==1)  flag=1;
3311  0139 7b04          	ld	a,(OFST+1,sp)
3312  013b a101          	cp	a,#1
3313  013d 2606          	jrne	L1741
3316  013f a601          	ld	a,#1
3317  0141 6b02          	ld	(OFST-1,sp),a
3319  0143 7b04          	ld	a,(OFST+1,sp)
3320  0145               L1741:
3321                     ; 712 			if(seg==2)  flag=1;
3323  0145 a102          	cp	a,#2
3324  0147 2606          	jrne	L3741
3327  0149 a601          	ld	a,#1
3328  014b 6b02          	ld	(OFST-1,sp),a
3330  014d 7b04          	ld	a,(OFST+1,sp)
3331  014f               L3741:
3332                     ; 713 			if(seg==5)  flag=1;
3334  014f a105          	cp	a,#5
3335  0151 2606          	jrne	L5741
3338  0153 a601          	ld	a,#1
3339  0155 6b02          	ld	(OFST-1,sp),a
3341  0157 7b04          	ld	a,(OFST+1,sp)
3342  0159               L5741:
3343                     ; 714 			if(seg==6)  flag=1;
3345  0159 a106          	cp	a,#6
3346  015b 2604          	jrne	L7641
3349  015d a601          	ld	a,#1
3350  015f 6b02          	ld	(OFST-1,sp),a
3352  0161               L7641:
3353                     ; 717 		if (num==5) {
3355  0161 7b01          	ld	a,(OFST-2,sp)
3356  0163 a105          	cp	a,#5
3357  0165 262f          	jrne	L1051
3358                     ; 719 			if(seg==0)  flag=1;
3360  0167 7b04          	ld	a,(OFST+1,sp)
3361  0169 2605          	jrne	L3051
3364  016b 4c            	inc	a
3365  016c 6b02          	ld	(OFST-1,sp),a
3367  016e 7b04          	ld	a,(OFST+1,sp)
3368  0170               L3051:
3369                     ; 720 			if(seg==2)  flag=1;
3371  0170 a102          	cp	a,#2
3372  0172 2606          	jrne	L5051
3375  0174 a601          	ld	a,#1
3376  0176 6b02          	ld	(OFST-1,sp),a
3378  0178 7b04          	ld	a,(OFST+1,sp)
3379  017a               L5051:
3380                     ; 721 			if(seg==3)  flag=1;
3382  017a a103          	cp	a,#3
3383  017c 2606          	jrne	L7051
3386  017e a601          	ld	a,#1
3387  0180 6b02          	ld	(OFST-1,sp),a
3389  0182 7b04          	ld	a,(OFST+1,sp)
3390  0184               L7051:
3391                     ; 722 			if(seg==5)  flag=1;
3393  0184 a105          	cp	a,#5
3394  0186 2606          	jrne	L1151
3397  0188 a601          	ld	a,#1
3398  018a 6b02          	ld	(OFST-1,sp),a
3400  018c 7b04          	ld	a,(OFST+1,sp)
3401  018e               L1151:
3402                     ; 723 			if(seg==6)  flag=1;
3404  018e a106          	cp	a,#6
3405  0190 2604          	jrne	L1051
3408  0192 a601          	ld	a,#1
3409  0194 6b02          	ld	(OFST-1,sp),a
3411  0196               L1051:
3412                     ; 725 		if (num==6) {
3414  0196 7b01          	ld	a,(OFST-2,sp)
3415  0198 a106          	cp	a,#6
3416  019a 2639          	jrne	L5151
3417                     ; 727 			if(seg==0)  flag=1;
3419  019c 7b04          	ld	a,(OFST+1,sp)
3420  019e 2605          	jrne	L7151
3423  01a0 4c            	inc	a
3424  01a1 6b02          	ld	(OFST-1,sp),a
3426  01a3 7b04          	ld	a,(OFST+1,sp)
3427  01a5               L7151:
3428                     ; 728 			if(seg==2)  flag=1;
3430  01a5 a102          	cp	a,#2
3431  01a7 2606          	jrne	L1251
3434  01a9 a601          	ld	a,#1
3435  01ab 6b02          	ld	(OFST-1,sp),a
3437  01ad 7b04          	ld	a,(OFST+1,sp)
3438  01af               L1251:
3439                     ; 729 			if(seg==3)  flag=1;
3441  01af a103          	cp	a,#3
3442  01b1 2606          	jrne	L3251
3445  01b3 a601          	ld	a,#1
3446  01b5 6b02          	ld	(OFST-1,sp),a
3448  01b7 7b04          	ld	a,(OFST+1,sp)
3449  01b9               L3251:
3450                     ; 730 			if(seg==4)  flag=1;
3452  01b9 a104          	cp	a,#4
3453  01bb 2606          	jrne	L5251
3456  01bd a601          	ld	a,#1
3457  01bf 6b02          	ld	(OFST-1,sp),a
3459  01c1 7b04          	ld	a,(OFST+1,sp)
3460  01c3               L5251:
3461                     ; 731 			if(seg==5)  flag=1;
3463  01c3 a105          	cp	a,#5
3464  01c5 2606          	jrne	L7251
3467  01c7 a601          	ld	a,#1
3468  01c9 6b02          	ld	(OFST-1,sp),a
3470  01cb 7b04          	ld	a,(OFST+1,sp)
3471  01cd               L7251:
3472                     ; 732 			if(seg==6)  flag=1;
3474  01cd a106          	cp	a,#6
3475  01cf 2604          	jrne	L5151
3478  01d1 a601          	ld	a,#1
3479  01d3 6b02          	ld	(OFST-1,sp),a
3481  01d5               L5151:
3482                     ; 734 		if (num==7) {
3484  01d5 7b01          	ld	a,(OFST-2,sp)
3485  01d7 a107          	cp	a,#7
3486  01d9 261b          	jrne	L3351
3487                     ; 736 			if(seg==0)  flag=1;
3489  01db 7b04          	ld	a,(OFST+1,sp)
3490  01dd 2605          	jrne	L5351
3493  01df 4c            	inc	a
3494  01e0 6b02          	ld	(OFST-1,sp),a
3496  01e2 7b04          	ld	a,(OFST+1,sp)
3497  01e4               L5351:
3498                     ; 737 			if(seg==1)  flag=1;
3500  01e4 a101          	cp	a,#1
3501  01e6 2606          	jrne	L7351
3504  01e8 a601          	ld	a,#1
3505  01ea 6b02          	ld	(OFST-1,sp),a
3507  01ec 7b04          	ld	a,(OFST+1,sp)
3508  01ee               L7351:
3509                     ; 738 			if(seg==2)  flag=1;
3511  01ee a102          	cp	a,#2
3512  01f0 2604          	jrne	L3351
3515  01f2 a601          	ld	a,#1
3516  01f4 6b02          	ld	(OFST-1,sp),a
3518  01f6               L3351:
3519                     ; 740 		if (num==8) {
3521  01f6 7b01          	ld	a,(OFST-2,sp)
3522  01f8 a108          	cp	a,#8
3523  01fa 2643          	jrne	L3451
3524                     ; 742 			if(seg==0) flag=1;
3526  01fc 7b04          	ld	a,(OFST+1,sp)
3527  01fe 2605          	jrne	L5451
3530  0200 4c            	inc	a
3531  0201 6b02          	ld	(OFST-1,sp),a
3533  0203 7b04          	ld	a,(OFST+1,sp)
3534  0205               L5451:
3535                     ; 743 			if(seg==1) flag=1;
3537  0205 a101          	cp	a,#1
3538  0207 2606          	jrne	L7451
3541  0209 a601          	ld	a,#1
3542  020b 6b02          	ld	(OFST-1,sp),a
3544  020d 7b04          	ld	a,(OFST+1,sp)
3545  020f               L7451:
3546                     ; 744 			if(seg==2)  flag=1;
3548  020f a102          	cp	a,#2
3549  0211 2606          	jrne	L1551
3552  0213 a601          	ld	a,#1
3553  0215 6b02          	ld	(OFST-1,sp),a
3555  0217 7b04          	ld	a,(OFST+1,sp)
3556  0219               L1551:
3557                     ; 745 			if(seg==3)  flag=1;
3559  0219 a103          	cp	a,#3
3560  021b 2606          	jrne	L3551
3563  021d a601          	ld	a,#1
3564  021f 6b02          	ld	(OFST-1,sp),a
3566  0221 7b04          	ld	a,(OFST+1,sp)
3567  0223               L3551:
3568                     ; 746 			if(seg==4)  flag=1;
3570  0223 a104          	cp	a,#4
3571  0225 2606          	jrne	L5551
3574  0227 a601          	ld	a,#1
3575  0229 6b02          	ld	(OFST-1,sp),a
3577  022b 7b04          	ld	a,(OFST+1,sp)
3578  022d               L5551:
3579                     ; 747 			if(seg==5)  flag=1;
3581  022d a105          	cp	a,#5
3582  022f 2606          	jrne	L7551
3585  0231 a601          	ld	a,#1
3586  0233 6b02          	ld	(OFST-1,sp),a
3588  0235 7b04          	ld	a,(OFST+1,sp)
3589  0237               L7551:
3590                     ; 748 			if(seg==6)  flag=1;
3592  0237 a106          	cp	a,#6
3593  0239 2604          	jrne	L3451
3596  023b a601          	ld	a,#1
3597  023d 6b02          	ld	(OFST-1,sp),a
3599  023f               L3451:
3600                     ; 750 		if (num==9) {
3602  023f 7b01          	ld	a,(OFST-2,sp)
3603  0241 a109          	cp	a,#9
3604  0243 2639          	jrne	L3651
3605                     ; 752 			if(seg==0) flag=1;
3607  0245 7b04          	ld	a,(OFST+1,sp)
3608  0247 2605          	jrne	L5651
3611  0249 4c            	inc	a
3612  024a 6b02          	ld	(OFST-1,sp),a
3614  024c 7b04          	ld	a,(OFST+1,sp)
3615  024e               L5651:
3616                     ; 753 			if(seg==1) flag=1;
3618  024e a101          	cp	a,#1
3619  0250 2606          	jrne	L7651
3622  0252 a601          	ld	a,#1
3623  0254 6b02          	ld	(OFST-1,sp),a
3625  0256 7b04          	ld	a,(OFST+1,sp)
3626  0258               L7651:
3627                     ; 754 			if(seg==2)  flag=1;
3629  0258 a102          	cp	a,#2
3630  025a 2606          	jrne	L1751
3633  025c a601          	ld	a,#1
3634  025e 6b02          	ld	(OFST-1,sp),a
3636  0260 7b04          	ld	a,(OFST+1,sp)
3637  0262               L1751:
3638                     ; 755 			if(seg==3)  flag=1;			
3640  0262 a103          	cp	a,#3
3641  0264 2606          	jrne	L3751
3644  0266 a601          	ld	a,#1
3645  0268 6b02          	ld	(OFST-1,sp),a
3647  026a 7b04          	ld	a,(OFST+1,sp)
3648  026c               L3751:
3649                     ; 756 			if(seg==5)  flag=1;
3651  026c a105          	cp	a,#5
3652  026e 2606          	jrne	L5751
3655  0270 a601          	ld	a,#1
3656  0272 6b02          	ld	(OFST-1,sp),a
3658  0274 7b04          	ld	a,(OFST+1,sp)
3659  0276               L5751:
3660                     ; 757 			if(seg==6)  flag=1;
3662  0276 a106          	cp	a,#6
3663  0278 2604          	jrne	L3651
3666  027a a601          	ld	a,#1
3667  027c 6b02          	ld	(OFST-1,sp),a
3669  027e               L3651:
3670                     ; 760 		if (num==10) {
3672  027e 7b01          	ld	a,(OFST-2,sp)
3673  0280 a10a          	cp	a,#10
3674  0282 262f          	jrne	L1061
3675                     ; 762 			if(seg==0) flag=1;
3677  0284 7b04          	ld	a,(OFST+1,sp)
3678  0286 2605          	jrne	L3061
3681  0288 4c            	inc	a
3682  0289 6b02          	ld	(OFST-1,sp),a
3684  028b 7b04          	ld	a,(OFST+1,sp)
3685  028d               L3061:
3686                     ; 763 			if(seg==1) flag=1;
3688  028d a101          	cp	a,#1
3689  028f 2606          	jrne	L5061
3692  0291 a601          	ld	a,#1
3693  0293 6b02          	ld	(OFST-1,sp),a
3695  0295 7b04          	ld	a,(OFST+1,sp)
3696  0297               L5061:
3697                     ; 766 			if(seg==4)  flag=1;
3699  0297 a104          	cp	a,#4
3700  0299 2606          	jrne	L7061
3703  029b a601          	ld	a,#1
3704  029d 6b02          	ld	(OFST-1,sp),a
3706  029f 7b04          	ld	a,(OFST+1,sp)
3707  02a1               L7061:
3708                     ; 767 			if(seg==5)  flag=1;
3710  02a1 a105          	cp	a,#5
3711  02a3 2606          	jrne	L1161
3714  02a5 a601          	ld	a,#1
3715  02a7 6b02          	ld	(OFST-1,sp),a
3717  02a9 7b04          	ld	a,(OFST+1,sp)
3718  02ab               L1161:
3719                     ; 768 			if(seg==6)  flag=1;
3721  02ab a106          	cp	a,#6
3722  02ad 2604          	jrne	L1061
3725  02af a601          	ld	a,#1
3726  02b1 6b02          	ld	(OFST-1,sp),a
3728  02b3               L1061:
3729                     ; 771 		if (num==11) {
3731  02b3 7b01          	ld	a,(OFST-2,sp)
3732  02b5 a10b          	cp	a,#11
3733  02b7 2625          	jrne	L5161
3734                     ; 773 			if(seg==0) flag=1;
3736  02b9 7b04          	ld	a,(OFST+1,sp)
3737  02bb 2605          	jrne	L7161
3740  02bd 4c            	inc	a
3741  02be 6b02          	ld	(OFST-1,sp),a
3743  02c0 7b04          	ld	a,(OFST+1,sp)
3744  02c2               L7161:
3745                     ; 777 			if(seg==4)  flag=1;
3747  02c2 a104          	cp	a,#4
3748  02c4 2606          	jrne	L1261
3751  02c6 a601          	ld	a,#1
3752  02c8 6b02          	ld	(OFST-1,sp),a
3754  02ca 7b04          	ld	a,(OFST+1,sp)
3755  02cc               L1261:
3756                     ; 778 			if(seg==5)  flag=1;
3758  02cc a105          	cp	a,#5
3759  02ce 2606          	jrne	L3261
3762  02d0 a601          	ld	a,#1
3763  02d2 6b02          	ld	(OFST-1,sp),a
3765  02d4 7b04          	ld	a,(OFST+1,sp)
3766  02d6               L3261:
3767                     ; 779 			if(seg==6)  flag=1;
3769  02d6 a106          	cp	a,#6
3770  02d8 2604          	jrne	L5161
3773  02da a601          	ld	a,#1
3774  02dc 6b02          	ld	(OFST-1,sp),a
3776  02de               L5161:
3777                     ; 782 		if (flag==1 && j==0 ) ON1;
3779  02de 7b02          	ld	a,(OFST-1,sp)
3780  02e0 a101          	cp	a,#1
3781  02e2 260f          	jrne	L7261
3783  02e4 0d03          	tnz	(OFST+0,sp)
3784  02e6 260b          	jrne	L7261
3787  02e8 4b20          	push	#32
3788  02ea ae500a        	ldw	x,#20490
3789  02ed cd0000        	call	_GPIO_WriteHigh
3791  02f0 84            	pop	a
3792  02f1 7b02          	ld	a,(OFST-1,sp)
3793  02f3               L7261:
3794                     ; 783 		if (flag==1 && j==1 ) ON2;
3796  02f3 4a            	dec	a
3797  02f4 260e          	jrne	L1361
3799  02f6 7b03          	ld	a,(OFST+0,sp)
3800  02f8 4a            	dec	a
3801  02f9 2609          	jrne	L1361
3804  02fb 4b40          	push	#64
3805  02fd ae500f        	ldw	x,#20495
3806  0300 cd0000        	call	_GPIO_WriteHigh
3808  0303 84            	pop	a
3809  0304               L1361:
3810                     ; 784 		if (flag==1 && j==2 ) ON3;
3812  0304 7b02          	ld	a,(OFST-1,sp)
3813  0306 4a            	dec	a
3814  0307 260f          	jrne	L3361
3816  0309 7b03          	ld	a,(OFST+0,sp)
3817  030b a102          	cp	a,#2
3818  030d 2609          	jrne	L3361
3821  030f 4b10          	push	#16
3822  0311 ae500f        	ldw	x,#20495
3823  0314 cd0000        	call	_GPIO_WriteHigh
3825  0317 84            	pop	a
3826  0318               L3361:
3827                     ; 672 	for (j=0;j<3;j++) {
3829  0318 0c03          	inc	(OFST+0,sp)
3833  031a 7b03          	ld	a,(OFST+0,sp)
3834  031c a103          	cp	a,#3
3835  031e 2403cc006b    	jrult	L5041
3836                     ; 788 }
3839  0323 5b04          	addw	sp,#4
3840  0325 81            	ret	
3875                     ; 790 void shownumber(u16 num) {
3876                     .text:	section	.text,new
3877  0000               _shownumber:
3879  0000 89            	pushw	x
3880  0001 88            	push	a
3881       00000001      OFST:	set	1
3884                     ; 791 	ind[0]=num/100;
3886  0002 a664          	ld	a,#100
3887  0004 62            	div	x,a
3888  0005 01            	rrwa	x,a
3889  0006 b700          	ld	_ind,a
3890                     ; 792 	ind[1]=num/10-ind[0]*10;
3892  0008 97            	ld	xl,a
3893  0009 a60a          	ld	a,#10
3894  000b 42            	mul	x,a
3895  000c 9f            	ld	a,xl
3896  000d 6b01          	ld	(OFST+0,sp),a
3898  000f a60a          	ld	a,#10
3899  0011 1e02          	ldw	x,(OFST+1,sp)
3900  0013 62            	div	x,a
3901  0014 01            	rrwa	x,a
3902  0015 1001          	sub	a,(OFST+0,sp)
3903  0017 b701          	ld	_ind+1,a
3904                     ; 793 	ind[2]=num - ind[0]*100 - ind[1]*10;
3906  0019 97            	ld	xl,a
3907  001a a60a          	ld	a,#10
3908  001c 42            	mul	x,a
3909  001d 9f            	ld	a,xl
3910  001e 6b01          	ld	(OFST+0,sp),a
3912  0020 b600          	ld	a,_ind
3913  0022 97            	ld	xl,a
3914  0023 a664          	ld	a,#100
3915  0025 42            	mul	x,a
3916  0026 9f            	ld	a,xl
3917  0027 1003          	sub	a,(OFST+2,sp)
3918  0029 40            	neg	a
3919  002a 1001          	sub	a,(OFST+0,sp)
3920  002c b702          	ld	_ind+2,a
3921                     ; 795 	if (ind[0]==0) {
3923  002e b600          	ld	a,_ind
3924  0030 260c          	jrne	L3561
3925                     ; 796 		ind[0]=20;
3927  0032 35140000      	mov	_ind,#20
3928                     ; 797 		if (ind[1]==0) ind[1]=20;
3930  0036 b601          	ld	a,_ind+1
3931  0038 2604          	jrne	L3561
3934  003a 35140001      	mov	_ind+1,#20
3935  003e               L3561:
3936                     ; 799 }
3939  003e 5b03          	addw	sp,#3
3940  0040 81            	ret	
3965                     ; 801 void sleep(void) {
3966                     .text:	section	.text,new
3967  0000               _sleep:
3971                     ; 807 	return;
3974  0000 81            	ret	
4014                     ; 845 void showinfo(u8 showind) {
4015                     .text:	section	.text,new
4016  0000               _showinfo:
4018  0000 88            	push	a
4019       00000000      OFST:	set	0
4022                     ; 846 	if (showind==0) {
4024  0001 4d            	tnz	a
4025  0002 260d          	jrne	L5071
4026                     ; 847 		ind[0]=11;
4028  0004 350b0000      	mov	_ind,#11
4029                     ; 848 		ind[1]=20;
4031  0008 35140001      	mov	_ind+1,#20
4032                     ; 849 		ind[2]=speedfan;
4034  000c 450902        	mov	_ind+2,_speedfan
4036  000f 2015          	jra	L7071
4037  0011               L5071:
4038                     ; 850 	}	else if (showind==1) {
4040  0011 a101          	cp	a,#1
4041  0013 2604          	jrne	L1171
4042                     ; 851 		shownumber(temp);
4044  0015 be0b          	ldw	x,_temp
4047  0017 200a          	jp	LC021
4048  0019               L1171:
4049                     ; 852 	} else if (showind==2) {
4051  0019 a102          	cp	a,#2
4052  001b 2604          	jrne	L5171
4053                     ; 853 		shownumber(hKi_Gain);
4055  001d be1b          	ldw	x,_hKi_Gain
4058  001f 2002          	jp	LC021
4059  0021               L5171:
4060                     ; 854 	}	else shownumber(mcpT);
4062  0021 be07          	ldw	x,_mcpT+2
4063  0023               LC021:
4064  0023 cd0000        	call	_shownumber
4066  0026               L7071:
4067                     ; 856 }
4070  0026 84            	pop	a
4071  0027 81            	ret	
4152                     	switch	.const
4153  007c               L255:
4154  007c 00000259      	dc.l	601
4155                     ; 858 void main(void)
4155                     ; 859 {
4156                     .text:	section	.text,new
4157  0000               _main:
4159  0000 88            	push	a
4160       00000001      OFST:	set	1
4163                     ; 861 	CLK->PCKENR1 = CLK_PCKENR1_TIM4+CLK_PCKENR1_TIM2+CLK_PCKENR1_I2C+CLK_PCKENR1_TIM1;	CLK->PCKENR2 = 0b01111111;
4165  0001 35b150c7      	mov	20679,#177
4168  0005 357f50ca      	mov	20682,#127
4169                     ; 863 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);//2mgh энергосбережение
4171  0009 a618          	ld	a,#24
4172  000b cd0000        	call	_CLK_HSIPrescalerConfig
4174                     ; 868 	GPIO_Init(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_HIGH_SLOW);
4176  000e 4bd0          	push	#208
4177  0010 4b7c          	push	#124
4178  0012 ae500f        	ldw	x,#20495
4179  0015 cd0000        	call	_GPIO_Init
4181  0018 85            	popw	x
4182                     ; 869 	GPIO_Init(GPIOA,GPIO_PIN_1|GPIO_PIN_2,GPIO_MODE_OUT_PP_HIGH_SLOW);
4184  0019 4bd0          	push	#208
4185  001b 4b06          	push	#6
4186  001d ae5000        	ldw	x,#20480
4187  0020 cd0000        	call	_GPIO_Init
4189  0023 85            	popw	x
4190                     ; 870 	GPIO_Init(GPIOC,GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7,GPIO_MODE_OUT_PP_HIGH_SLOW);
4192  0024 4bd0          	push	#208
4193  0026 4be0          	push	#224
4194  0028 ae500a        	ldw	x,#20490
4195  002b cd0000        	call	_GPIO_Init
4197  002e 85            	popw	x
4198                     ; 872 	GPIO_WriteHigh(GPIOC,GPIO_PIN_1);
4200  002f 4b02          	push	#2
4201  0031 ae500a        	ldw	x,#20490
4202  0034 cd0000        	call	_GPIO_WriteHigh
4204  0037 84            	pop	a
4205                     ; 873 	GPIO_WriteLow(GPIOA,GPIO_PIN_2);
4207  0038 4b04          	push	#4
4208  003a ae5000        	ldw	x,#20480
4209  003d cd0000        	call	_GPIO_WriteLow
4211  0040 84            	pop	a
4212                     ; 875 	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);//PWM FAN
4214  0041 4be0          	push	#224
4215  0043 4b08          	push	#8
4216  0045 ae500a        	ldw	x,#20490
4217  0048 cd0000        	call	_GPIO_Init
4219  004b 85            	popw	x
4220                     ; 876 	GPIO_Init(GPIOA,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);//Spiral
4222  004c 4be0          	push	#224
4223  004e 4b08          	push	#8
4224  0050 ae5000        	ldw	x,#20480
4225  0053 cd0000        	call	_GPIO_Init
4227  0056 85            	popw	x
4228                     ; 880 	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_IN_FL_NO_IT);//кнопка!
4230  0057 4b00          	push	#0
4231  0059 4b10          	push	#16
4232  005b ae500a        	ldw	x,#20490
4233  005e cd0000        	call	_GPIO_Init
4235  0061 85            	popw	x
4236                     ; 881 	ADC1_DeInit();
4238  0062 cd0000        	call	_ADC1_DeInit
4240                     ; 882 	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, ADC1_CHANNEL_2, ADC1_PRESSEL_FCPU_D2, \
4240                     ; 883             ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SCHMITTTRIG_CHANNEL2,\
4240                     ; 884             DISABLE);
4242  0065 4b00          	push	#0
4243  0067 4b02          	push	#2
4244  0069 4b08          	push	#8
4245  006b 4b00          	push	#0
4246  006d 4b00          	push	#0
4247  006f 4b00          	push	#0
4248  0071 ae0002        	ldw	x,#2
4249  0074 cd0000        	call	_ADC1_Init
4251  0077 5b06          	addw	sp,#6
4252                     ; 885 	ADC1_Cmd(ENABLE);
4254  0079 a601          	ld	a,#1
4255  007b cd0000        	call	_ADC1_Cmd
4257                     ; 899 	TIM4_TimeBaseInit(TIM4_PRESCALER_8, 249);
4259  007e ae03f9        	ldw	x,#1017
4260  0081 cd0000        	call	_TIM4_TimeBaseInit
4262                     ; 900   TIM4_ClearFlag(TIM4_FLAG_UPDATE);
4264  0084 a601          	ld	a,#1
4265  0086 cd0000        	call	_TIM4_ClearFlag
4267                     ; 901 	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
4269  0089 ae0101        	ldw	x,#257
4270  008c cd0000        	call	_TIM4_ITConfig
4272                     ; 902   TIM4->IER |= (uint8_t)TIM4_IT_UPDATE;
4274  008f 72105343      	bset	21315,#0
4275                     ; 907 	enableInterrupts();
4278  0093 9a            	rim	
4280                     ; 910 	TIM4_Cmd(ENABLE);
4283  0094 a601          	ld	a,#1
4284  0096 cd0000        	call	_TIM4_Cmd
4286                     ; 913 	TIM2_TimeBaseInit(TIM2_PRESCALER_8, 249);
4288  0099 ae00f9        	ldw	x,#249
4289  009c 89            	pushw	x
4290  009d a603          	ld	a,#3
4291  009f cd0000        	call	_TIM2_TimeBaseInit
4293  00a2 85            	popw	x
4294                     ; 914   TIM2_ClearFlag(TIM2_FLAG_UPDATE);
4296  00a3 ae0001        	ldw	x,#1
4297  00a6 cd0000        	call	_TIM2_ClearFlag
4299                     ; 915 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
4301  00a9 ae0101        	ldw	x,#257
4302  00ac cd0000        	call	_TIM2_ITConfig
4304                     ; 916   TIM2->IER |= (uint8_t)TIM2_IT_UPDATE;
4306  00af 72105303      	bset	21251,#0
4307                     ; 920 	TIM1_DeInit();
4309  00b3 cd0000        	call	_TIM1_DeInit
4311                     ; 921 	TIM1_TimeBaseInit(36000, TIM1_COUNTERMODE_UP, MAXPWM, 0);
4313  00b6 4b00          	push	#0
4314  00b8 ae0005        	ldw	x,#5
4315  00bb 89            	pushw	x
4316  00bc 4b00          	push	#0
4317  00be ae8ca0        	ldw	x,#36000
4318  00c1 cd0000        	call	_TIM1_TimeBaseInit
4320  00c4 5b04          	addw	sp,#4
4321                     ; 923 	TIM1_CCPreloadControl(DISABLE);
4323  00c6 4f            	clr	a
4324  00c7 cd0000        	call	_TIM1_CCPreloadControl
4326                     ; 925 	TIM1_BDTRConfig(TIM1_OSSISTATE_DISABLE,
4326                     ; 926                      TIM1_LOCKLEVEL_OFF,
4326                     ; 927                      0,
4326                     ; 928                      TIM1_BREAK_DISABLE,
4326                     ; 929                      TIM1_BREAKPOLARITY_LOW,TIM1_AUTOMATICOUTPUT_DISABLE);
4328  00ca 4b00          	push	#0
4329  00cc 4b00          	push	#0
4330  00ce 4b00          	push	#0
4331  00d0 4b00          	push	#0
4332  00d2 5f            	clrw	x
4333  00d3 cd0000        	call	_TIM1_BDTRConfig
4335  00d6 5b04          	addw	sp,#4
4336                     ; 931 	TIM1_OC1Init(TIM1_OCMODE_PWM2, TIM1_OUTPUTSTATE_DISABLE, TIM1_OUTPUTNSTATE_DISABLE,
4336                     ; 932                0, TIM1_OCPOLARITY_LOW, TIM1_OCNPOLARITY_HIGH, TIM1_OCIDLESTATE_SET,
4336                     ; 933                TIM1_OCNIDLESTATE_RESET); 
4338  00d8 4b00          	push	#0
4339  00da 4b55          	push	#85
4340  00dc 4b00          	push	#0
4341  00de 4b22          	push	#34
4342  00e0 5f            	clrw	x
4343  00e1 89            	pushw	x
4344  00e2 4b00          	push	#0
4345  00e4 ae7000        	ldw	x,#28672
4346  00e7 cd0000        	call	_TIM1_OC1Init
4348  00ea 5b07          	addw	sp,#7
4349                     ; 935   TIM1_CtrlPWMOutputs(DISABLE); //vse v preryvanii!
4351  00ec 4f            	clr	a
4352  00ed cd0000        	call	_TIM1_CtrlPWMOutputs
4354                     ; 936 	TIM1_Cmd(ENABLE);
4356  00f0 a601          	ld	a,#1
4357  00f2 cd0000        	call	_TIM1_Cmd
4359                     ; 937 	TIM1_ITConfig(TIM1_IT_UPDATE|TIM1_IT_CC1, ENABLE);
4361  00f5 ae0301        	ldw	x,#769
4362  00f8 cd0000        	call	_TIM1_ITConfig
4364                     ; 946 	Delay(100);
4366  00fb ae0064        	ldw	x,#100
4367  00fe cd0000        	call	_Delay
4369                     ; 948 	bmeT=0;
4371  0101 5f            	clrw	x
4372  0102 bf03          	ldw	_bmeT+2,x
4373  0104 bf01          	ldw	_bmeT,x
4374                     ; 950 	TIM2_Cmd(ENABLE);
4376  0106 a601          	ld	a,#1
4377  0108 cd0000        	call	_TIM2_Cmd
4379                     ; 953 	I2C_Cmd( ENABLE);
4381  010b a601          	ld	a,#1
4382  010d cd0000        	call	_I2C_Cmd
4384                     ; 954   I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);
4386  0110 4b07          	push	#7
4387  0112 4b00          	push	#0
4388  0114 4b01          	push	#1
4389  0116 4b00          	push	#0
4390  0118 ae00a0        	ldw	x,#160
4391  011b 89            	pushw	x
4392  011c ae86a0        	ldw	x,#34464
4393  011f 89            	pushw	x
4394  0120 ae0001        	ldw	x,#1
4395  0123 89            	pushw	x
4396  0124 cd0000        	call	_I2C_Init
4398  0127 5b0a          	addw	sp,#10
4399                     ; 956 	mcpinit();
4401  0129 cd0000        	call	_mcpinit
4403                     ; 958 	nctinit();
4405  012c cd0000        	call	_nctinit
4407                     ; 963 	if (fan==0) {
4409  012f b607          	ld	a,_fan
4410  0131 260e          	jrne	L7371
4411                     ; 964 		ind[0] = 10;//P
4413  0133 350a0000      	mov	_ind,#10
4414                     ; 965 		ind[1] = 10;//P
4416  0137 350a0001      	mov	_ind+1,#10
4417                     ; 966 		ind[2] = 10;//P
4419  013b 350a0002      	mov	_ind+2,#10
4421  013f 200c          	jra	L1471
4422  0141               L7371:
4423                     ; 968 		ind[0] = 11;//F
4425  0141 350b0000      	mov	_ind,#11
4426                     ; 969 		ind[1] = 11;//F
4428  0145 350b0001      	mov	_ind+1,#11
4429                     ; 970 		ind[2] = 11;//F
4431  0149 350b0002      	mov	_ind+2,#11
4432  014d               L1471:
4433                     ; 972 	Delay(3000);
4435  014d ae0bb8        	ldw	x,#3000
4436  0150 cd0000        	call	_Delay
4438  0153               L3471:
4439                     ; 981 			for (i=0;i<4;i++) {
4441  0153 4f            	clr	a
4442  0154 6b01          	ld	(OFST+0,sp),a
4444  0156               L7471:
4445                     ; 982 				if (kn[i]==KNTWO) {
4447  0156 5f            	clrw	x
4448  0157 97            	ld	xl,a
4449  0158 e636          	ld	a,(_kn,x)
4450  015a a106          	cp	a,#6
4451  015c 2615          	jrne	L5571
4452                     ; 983 					kn[i]=0;
4454  015e 7b01          	ld	a,(OFST+0,sp)
4455  0160 5f            	clrw	x
4456  0161 97            	ld	xl,a
4457                     ; 984 					spiralpower=0;
4459  0162 3f11          	clr	_spiralpower
4460  0164 6f36          	clr	(_kn,x)
4461                     ; 985 					temp=0;
4463  0166 5f            	clrw	x
4464  0167 bf0b          	ldw	_temp,x
4465                     ; 986 					shownumber(999);
4467  0169 ae03e7        	ldw	x,#999
4468  016c cd0000        	call	_shownumber
4470                     ; 987 					timeshownext=3;
4472  016f 3503000f      	mov	_timeshownext,#3
4473  0173               L5571:
4474                     ; 981 			for (i=0;i<4;i++) {
4476  0173 0c01          	inc	(OFST+0,sp)
4480  0175 7b01          	ld	a,(OFST+0,sp)
4481  0177 a104          	cp	a,#4
4482  0179 25db          	jrult	L7471
4483                     ; 992 		if (kn[1] == KNONE) {
4485  017b b637          	ld	a,_kn+1
4486  017d a104          	cp	a,#4
4487  017f 2611          	jrne	L7571
4488                     ; 994 			kn[1]=0;			
4490  0181 3f37          	clr	_kn+1
4491                     ; 995 			temp-=10;
4493  0183 be0b          	ldw	x,_temp
4494  0185 1d000a        	subw	x,#10
4495  0188 bf0b          	ldw	_temp,x
4496                     ; 996 			if (temp>1000) temp=0;
4498  018a a303e9        	cpw	x,#1001
4499  018d 2503          	jrult	L7571
4502  018f 5f            	clrw	x
4503  0190 bf0b          	ldw	_temp,x
4504  0192               L7571:
4505                     ; 998 		if (kn[1] == KNLONG) {
4507  0192 b637          	ld	a,_kn+1
4508  0194 a105          	cp	a,#5
4509  0196 2611          	jrne	L3671
4510                     ; 1000 			kn[1]=0;			
4512  0198 3f37          	clr	_kn+1
4513                     ; 1001 			temp-=100;
4515  019a be0b          	ldw	x,_temp
4516  019c 1d0064        	subw	x,#100
4517  019f bf0b          	ldw	_temp,x
4518                     ; 1002 			if (temp>1000) temp=0;
4520  01a1 a303e9        	cpw	x,#1001
4521  01a4 2503          	jrult	L3671
4524  01a6 5f            	clrw	x
4525  01a7 bf0b          	ldw	_temp,x
4526  01a9               L3671:
4527                     ; 1005 		if (kn[2] == KNONE) {
4529  01a9 b638          	ld	a,_kn+2
4530  01ab a104          	cp	a,#4
4531  01ad 2613          	jrne	L7671
4532                     ; 1007 			kn[2]=0;			
4534  01af 3f38          	clr	_kn+2
4535                     ; 1008 			temp+=10;
4537  01b1 be0b          	ldw	x,_temp
4538  01b3 1c000a        	addw	x,#10
4539  01b6 bf0b          	ldw	_temp,x
4540                     ; 1009 			if (temp>500) temp=500;
4542  01b8 a301f5        	cpw	x,#501
4543  01bb 2505          	jrult	L7671
4546  01bd ae01f4        	ldw	x,#500
4547  01c0 bf0b          	ldw	_temp,x
4548  01c2               L7671:
4549                     ; 1011 		if (kn[2] == KNLONG) {
4551  01c2 b638          	ld	a,_kn+2
4552  01c4 a105          	cp	a,#5
4553  01c6 2613          	jrne	L3771
4554                     ; 1013 			kn[2]=0;			
4556  01c8 3f38          	clr	_kn+2
4557                     ; 1014 			temp+=100;
4559  01ca be0b          	ldw	x,_temp
4560  01cc 1c0064        	addw	x,#100
4561  01cf bf0b          	ldw	_temp,x
4562                     ; 1015 			if (temp>500) temp=500;
4564  01d1 a301f5        	cpw	x,#501
4565  01d4 2505          	jrult	L3771
4568  01d6 ae01f4        	ldw	x,#500
4569  01d9 bf0b          	ldw	_temp,x
4570  01db               L3771:
4571                     ; 1020 		if ((kn[0] == KNONE) || (kn[0] == KNLONG)) {
4573  01db b636          	ld	a,_kn
4574  01dd a104          	cp	a,#4
4575  01df 2704          	jreq	L1002
4577  01e1 a105          	cp	a,#5
4578  01e3 260d          	jrne	L7771
4579  01e5               L1002:
4580                     ; 1022 			kn[0]=0;			
4582  01e5 3f36          	clr	_kn
4583                     ; 1023 			speedfan--;
4585  01e7 3a09          	dec	_speedfan
4586                     ; 1024 			if (speedfan==0) speedfan=1;
4588  01e9 2604          	jrne	L3002
4591  01eb 35010009      	mov	_speedfan,#1
4592  01ef               L3002:
4593                     ; 1028 			timeshownext=2;
4595  01ef cd029e        	call	LC022
4597  01f2               L7771:
4598                     ; 1033 		if ((kn[3] == KNONE) || (kn[3] == KNLONG)) {
4600  01f2 b639          	ld	a,_kn+3
4601  01f4 a104          	cp	a,#4
4602  01f6 2704          	jreq	L7002
4604  01f8 a105          	cp	a,#5
4605  01fa 2611          	jrne	L5002
4606  01fc               L7002:
4607                     ; 1035 			kn[3]=0;			
4609  01fc 3f39          	clr	_kn+3
4610                     ; 1036 			speedfan++;
4612  01fe 3c09          	inc	_speedfan
4613                     ; 1037 			if (speedfan>4) speedfan=4;
4615  0200 b609          	ld	a,_speedfan
4616  0202 a105          	cp	a,#5
4617  0204 2504          	jrult	L1102
4620  0206 35040009      	mov	_speedfan,#4
4621  020a               L1102:
4622                     ; 1041 			timeshownext=2;
4624  020a cd029e        	call	LC022
4626  020d               L5002:
4627                     ; 1045 		if (temp != tempold) {			
4629  020d be0b          	ldw	x,_temp
4630  020f b30d          	cpw	x,_tempold
4631  0211 270d          	jreq	L3102
4632                     ; 1047 			timeshownext=2;
4634  0213 3502000f      	mov	_timeshownext,#2
4635                     ; 1048 			showinfo(1);
4637  0217 a601          	ld	a,#1
4638  0219 cd0000        	call	_showinfo
4640                     ; 1050 			tempold = temp;
4642  021c be0b          	ldw	x,_temp
4643  021e bf0d          	ldw	_tempold,x
4644  0220               L3102:
4645                     ; 1053 		if (speedfan != speedfanold) {			
4647  0220 b609          	ld	a,_speedfan
4648  0222 b10a          	cp	a,_speedfanold
4649  0224 270a          	jreq	L5102
4650                     ; 1055 			timeshownext=2;
4652  0226 ad76          	call	LC022
4654                     ; 1058 			speedfanold = speedfan;
4656  0228 b609          	ld	a,_speedfan
4657  022a b70a          	ld	_speedfanold,a
4658                     ; 1059 			TIM1->CCR1L = (MAXPWM-4)+(uint8_t)(speedfan);
4660  022c 4c            	inc	a
4661  022d c75266        	ld	21094,a
4662  0230               L5102:
4663                     ; 1062 		if (timeshownext==0) {
4665  0230 b60f          	ld	a,_timeshownext
4666  0232 2613          	jrne	L7102
4667                     ; 1063 			timeshownext= 1;
4669  0234 3501000f      	mov	_timeshownext,#1
4670                     ; 1065 			showinfo(10);
4672  0238 a60a          	ld	a,#10
4673  023a cd0000        	call	_showinfo
4675                     ; 1067 			showind++;
4677  023d 3c10          	inc	_showind
4678                     ; 1068 			if (showind>=6) showind = 0;			
4680  023f b610          	ld	a,_showind
4681  0241 a106          	cp	a,#6
4682  0243 2502          	jrult	L7102
4685  0245 3f10          	clr	_showind
4686  0247               L7102:
4687                     ; 1117 		if (timemcp==0)  {
4689  0247 be20          	ldw	x,_timemcp
4690  0249 2703cc0153    	jrne	L3471
4691                     ; 1118 			nctdata();
4693  024e cd0000        	call	_nctdata
4695                     ; 1120 			if (mcpdata()==0){
4697  0251 cd0000        	call	_mcpdata
4699  0254 5d            	tnzw	x
4700  0255 260a          	jrne	L5202
4701                     ; 1122 				mcpT = 999;
4703  0257 ae03e7        	ldw	x,#999
4704  025a bf07          	ldw	_mcpT+2,x
4705  025c 5f            	clrw	x
4706  025d bf05          	ldw	_mcpT,x
4708  025f 2012          	jra	L7202
4709  0261               L5202:
4710                     ; 1123 			} else mcpT /= 100;
4712  0261 ae0005        	ldw	x,#_mcpT
4713  0264 cd0000        	call	c_ltor
4715  0267 ae0078        	ldw	x,#L431
4716  026a cd0000        	call	c_ldiv
4718  026d ae0005        	ldw	x,#_mcpT
4719  0270 cd0000        	call	c_rtol
4721  0273               L7202:
4722                     ; 1125 			if ((temp==0) || (mcpT > 600)) {
4724  0273 be0b          	ldw	x,_temp
4725  0275 270e          	jreq	L3302
4727  0277 ae0005        	ldw	x,#_mcpT
4728  027a cd0000        	call	c_ltor
4730  027d ae007c        	ldw	x,#L255
4731  0280 cd0000        	call	c_lcmp
4733  0283 2f0a          	jrslt	L1302
4734  0285               L3302:
4735                     ; 1126 				spiralpower=0;
4737  0285 3f11          	clr	_spiralpower
4739  0287               L5302:
4740                     ; 1132 			timemcp=300;
4742  0287 ae012c        	ldw	x,#300
4743  028a bf20          	ldw	_timemcp,x
4744  028c cc0153        	jra	L3471
4745  028f               L1302:
4746                     ; 1128 				spiralpower = PI_Regulator(temp, mcpT);
4748  028f be07          	ldw	x,_mcpT+2
4749  0291 89            	pushw	x
4750  0292 be0b          	ldw	x,_temp
4751  0294 cd0000        	call	_PI_Regulator
4753  0297 5b02          	addw	sp,#2
4754  0299 01            	rrwa	x,a
4755  029a b711          	ld	_spiralpower,a
4756  029c 20e9          	jra	L5302
4757  029e               LC022:
4758  029e 3502000f      	mov	_timeshownext,#2
4759                     ; 1056 			showinfo(0);
4761  02a2 4f            	clr	a
4762  02a3 cc0000        	jp	_showinfo
4827                     ; 1162 uint32_t LSIMeasurment(void)
4827                     ; 1163 {
4828                     .text:	section	.text,new
4829  0000               _LSIMeasurment:
4831  0000 520c          	subw	sp,#12
4832       0000000c      OFST:	set	12
4835                     ; 1165   uint32_t lsi_freq_hz = 0x0;
4837                     ; 1166   uint32_t fmaster = 0x0;
4839                     ; 1167   uint16_t ICValue1 = 0x0;
4841                     ; 1168   uint16_t ICValue2 = 0x0;
4843                     ; 1171   fmaster = CLK_GetClockFreq();
4845  0002 cd0000        	call	_CLK_GetClockFreq
4847  0005 96            	ldw	x,sp
4848  0006 1c0009        	addw	x,#OFST-3
4849  0009 cd0000        	call	c_rtol
4852                     ; 1174   AWU->CSR |= AWU_CSR_MSR;
4854  000c 721050f0      	bset	20720,#0
4855                     ; 1186 	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
4857  0010 7211525c      	bres	21084,#0
4858                     ; 1189   TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
4858                     ; 1190                           (uint8_t)(( (TIM1_ICSELECTION_DIRECTTI)) | ((uint8_t)( 0 << 4))));
4860  0014 c65258        	ld	a,21080
4861  0017 a40c          	and	a,#12
4862  0019 aa01          	or	a,#1
4863  001b c75258        	ld	21080,a
4864                     ; 1191 	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
4866  001e 7213525c      	bres	21084,#1
4867                     ; 1192 	TIM1->CCER1 |=  TIM1_CCER1_CC1E;
4869  0022 7210525c      	bset	21084,#0
4870                     ; 1196 	TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
4870                     ; 1197                           | (uint8_t)TIM1_ICPSC_DIV8);
4872  0026 c65258        	ld	a,21080
4873  0029 aa0c          	or	a,#12
4874  002b c75258        	ld	21080,a
4875                     ; 1201 	TIM1->CR1 |= TIM1_CR1_CEN;
4877  002e 72105250      	bset	21072,#0
4879  0032               L3702:
4880                     ; 1204   while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
4882  0032 72035255fb    	btjf	21077,#1,L3702
4883                     ; 1206   ICValue1 = TIM1_GetCapture1();
4885  0037 cd0000        	call	_TIM1_GetCapture1
4887  003a 1f05          	ldw	(OFST-7,sp),x
4889                     ; 1207   TIM1_ClearFlag(TIM1_FLAG_CC1);
4891  003c ae0002        	ldw	x,#2
4892  003f cd0000        	call	_TIM1_ClearFlag
4895  0042               L1012:
4896                     ; 1210   while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
4898  0042 72035255fb    	btjf	21077,#1,L1012
4899                     ; 1212   ICValue2 = TIM1_GetCapture1();
4901  0047 cd0000        	call	_TIM1_GetCapture1
4903  004a 1f07          	ldw	(OFST-5,sp),x
4905                     ; 1213   TIM1_ClearFlag(TIM1_FLAG_CC1);
4907  004c ae0002        	ldw	x,#2
4908  004f cd0000        	call	_TIM1_ClearFlag
4910                     ; 1216   TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
4912  0052 7211525c      	bres	21084,#0
4913                     ; 1218   TIM1_Cmd(DISABLE);
4915  0056 4f            	clr	a
4916  0057 cd0000        	call	_TIM1_Cmd
4918                     ; 1249   lsi_freq_hz = (8 * fmaster) / (ICValue2 - ICValue1);
4920  005a 1e07          	ldw	x,(OFST-5,sp)
4921  005c 72f005        	subw	x,(OFST-7,sp)
4922  005f cd0000        	call	c_uitolx
4924  0062 96            	ldw	x,sp
4925  0063 5c            	incw	x
4926  0064 cd0000        	call	c_rtol
4929  0067 96            	ldw	x,sp
4930  0068 1c0009        	addw	x,#OFST-3
4931  006b cd0000        	call	c_ltor
4933  006e a603          	ld	a,#3
4934  0070 cd0000        	call	c_llsh
4936  0073 96            	ldw	x,sp
4937  0074 5c            	incw	x
4938  0075 cd0000        	call	c_ludv
4940  0078 96            	ldw	x,sp
4941  0079 1c0009        	addw	x,#OFST-3
4942  007c cd0000        	call	c_rtol
4945                     ; 1252   AWU->CSR &= (uint8_t)(~AWU_CSR_MSR);
4947  007f 721150f0      	bres	20720,#0
4948                     ; 1254  return (lsi_freq_hz);
4950  0083 96            	ldw	x,sp
4951  0084 1c0009        	addw	x,#OFST-3
4952  0087 cd0000        	call	c_ltor
4956  008a 5b0c          	addw	sp,#12
4957  008c 81            	ret	
4960                     	bsct
4961  0034               _timedelay:
4962  0034 0000          	dc.w	0
4995                     ; 1259 void Delay(u16 nCount)
4995                     ; 1260 {
4996                     .text:	section	.text,new
4997  0000               _Delay:
5001                     ; 1262     timedelay = nCount;
5003  0000 bf34          	ldw	_timedelay,x
5005  0002               L7212:
5006                     ; 1264 		while (timedelay);
5008  0002 be34          	ldw	x,_timedelay
5009  0004 26fc          	jrne	L7212
5010                     ; 1265 }
5013  0006 81            	ret	
5068                     ; 1267 void knint(u8 knum, u8 zn,u8 pin) {
5069                     .text:	section	.text,new
5070  0000               _knint:
5072  0000 89            	pushw	x
5073       00000000      OFST:	set	0
5076                     ; 1269 	if (knstatus[knum] && ((zn&pin) == 0)) {//кнопку нажали
5078  0001 9e            	ld	a,xh
5079  0002 5f            	clrw	x
5080  0003 97            	ld	xl,a
5081  0004 e632          	ld	a,(_knstatus,x)
5082  0006 2754          	jreq	L1612
5084  0008 7b02          	ld	a,(OFST+2,sp)
5085  000a 1505          	bcp	a,(OFST+5,sp)
5086  000c 264e          	jrne	L1612
5087                     ; 1270 		knstatus[knum] = zn&pin;
5089  000e 7b01          	ld	a,(OFST+1,sp)
5090  0010 5f            	clrw	x
5091  0011 97            	ld	xl,a
5092  0012 7b02          	ld	a,(OFST+2,sp)
5093  0014 1405          	and	a,(OFST+5,sp)
5094  0016 e732          	ld	(_knstatus,x),a
5095                     ; 1271 		if (kn[knum]>=KNONE) return; //еще не обработали предыдущее нажатие в основном цикле пропустим это нажатие
5097  0018 5f            	clrw	x
5098  0019 7b01          	ld	a,(OFST+1,sp)
5099  001b 97            	ld	xl,a
5100  001c e636          	ld	a,(_kn,x)
5101  001e a104          	cp	a,#4
5102  0020 2502          	jrult	L3612
5106  0022 85            	popw	x
5107  0023 81            	ret	
5108  0024               L3612:
5109                     ; 1273 		kn[knum]++;//колво нажатий плюс один
5111  0024 7b01          	ld	a,(OFST+1,sp)
5112  0026 5f            	clrw	x
5113  0027 97            	ld	xl,a
5114  0028 6c36          	inc	(_kn,x)
5115                     ; 1274 		if (kn[knum]==1) kntime[knum] = KNTIMELONG;//первый раз начнм замер времени
5117  002a ad7b          	call	LC024
5118  002c 4a            	dec	a
5119  002d 260b          	jrne	L5612
5122  002f 7b01          	ld	a,(OFST+1,sp)
5123  0031 5f            	clrw	x
5124  0032 97            	ld	xl,a
5125  0033 58            	sllw	x
5126  0034 90ae03e8      	ldw	y,#1000
5127  0038 ef2a          	ldw	(_kntime,x),y
5128  003a               L5612:
5129                     ; 1276 		if (kn[knum]==2) {
5131  003a 7b01          	ld	a,(OFST+1,sp)
5132  003c ad69          	call	LC024
5133  003e a102          	cp	a,#2
5134  0040 261a          	jrne	L1612
5135                     ; 1277 			if (kntime[knum] > (KNTIMELONG-KNTIMETWO) ) kn[knum] = KNTWO;
5137  0042 7b01          	ld	a,(OFST+1,sp)
5138  0044 5f            	clrw	x
5139  0045 97            	ld	xl,a
5140  0046 58            	sllw	x
5141  0047 9093          	ldw	y,x
5142  0049 90ee2a        	ldw	y,(_kntime,y)
5143  004c 90a302bd      	cpw	y,#701
5144  0050 5f            	clrw	x
5145  0051 97            	ld	xl,a
5146  0052 2504          	jrult	L1712
5149  0054 a606          	ld	a,#6
5151  0056 2002          	jp	LC023
5152  0058               L1712:
5153                     ; 1278 			else kn[knum] = KNONE;
5155  0058 a604          	ld	a,#4
5156  005a               LC023:
5157  005a e736          	ld	(_kn,x),a
5158  005c               L1612:
5159                     ; 1282 	if ((kn[knum]==1) && (kntime[knum]==0)) kn[knum]=KNLONG;
5161  005c 7b01          	ld	a,(OFST+1,sp)
5162  005e ad47          	call	LC024
5163  0060 4a            	dec	a
5164  0061 2613          	jrne	L5712
5166  0063 7b01          	ld	a,(OFST+1,sp)
5167  0065 5f            	clrw	x
5168  0066 97            	ld	xl,a
5169  0067 58            	sllw	x
5170  0068 e62b          	ld	a,(_kntime+1,x)
5171  006a ea2a          	or	a,(_kntime,x)
5172  006c 2608          	jrne	L5712
5175  006e 7b01          	ld	a,(OFST+1,sp)
5176  0070 5f            	clrw	x
5177  0071 97            	ld	xl,a
5178  0072 a605          	ld	a,#5
5179  0074 e736          	ld	(_kn,x),a
5180  0076               L5712:
5181                     ; 1283 	if ((kn[knum]==1) && (kntime[knum]<(KNTIMELONG-KNTIMETWO)) && zn&pin) kn[knum]=KNONE;
5183  0076 7b01          	ld	a,(OFST+1,sp)
5184  0078 ad2d          	call	LC024
5185  007a 4a            	dec	a
5186  007b 261e          	jrne	L7712
5188  007d 7b01          	ld	a,(OFST+1,sp)
5189  007f 5f            	clrw	x
5190  0080 97            	ld	xl,a
5191  0081 58            	sllw	x
5192  0082 9093          	ldw	y,x
5193  0084 90ee2a        	ldw	y,(_kntime,y)
5194  0087 90a302bc      	cpw	y,#700
5195  008b 240e          	jruge	L7712
5197  008d 7b02          	ld	a,(OFST+2,sp)
5198  008f 1505          	bcp	a,(OFST+5,sp)
5199  0091 2708          	jreq	L7712
5202  0093 7b01          	ld	a,(OFST+1,sp)
5203  0095 5f            	clrw	x
5204  0096 97            	ld	xl,a
5205  0097 a604          	ld	a,#4
5206  0099 e736          	ld	(_kn,x),a
5207  009b               L7712:
5208                     ; 1285 	knstatus[knum] = zn&pin;
5210  009b 7b01          	ld	a,(OFST+1,sp)
5211  009d 5f            	clrw	x
5212  009e 97            	ld	xl,a
5213  009f 7b02          	ld	a,(OFST+2,sp)
5214  00a1 1405          	and	a,(OFST+5,sp)
5215  00a3 e732          	ld	(_knstatus,x),a
5216                     ; 1287 }	 
5219  00a5 85            	popw	x
5220  00a6 81            	ret	
5221  00a7               LC024:
5222  00a7 5f            	clrw	x
5223  00a8 97            	ld	xl,a
5224  00a9 e636          	ld	a,(_kn,x)
5225  00ab 81            	ret	
5228                     	bsct
5229  0036               _timesec:
5230  0036 0000          	dc.w	0
5307                     ; 1292 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
5307                     ; 1293  {
5309                     .text:	section	.text,new
5310  0000               f_TIM4_UPD_OVF_IRQHandler:
5312  0000 8a            	push	cc
5313  0001 84            	pop	a
5314  0002 a4bf          	and	a,#191
5315  0004 88            	push	a
5316  0005 86            	pop	cc
5317       00000004      OFST:	set	4
5318  0006 3b0002        	push	c_x+2
5319  0009 be00          	ldw	x,c_x
5320  000b 89            	pushw	x
5321  000c 3b0002        	push	c_y+2
5322  000f be00          	ldw	x,c_y
5323  0011 89            	pushw	x
5324  0012 5204          	subw	sp,#4
5327                     ; 1297 	if (timedelay) timedelay--;
5329  0014 be34          	ldw	x,_timedelay
5330  0016 2703          	jreq	L3322
5333  0018 5a            	decw	x
5334  0019 bf34          	ldw	_timedelay,x
5335  001b               L3322:
5336                     ; 1299 	if (timenct) timenct--;
5338  001b be1e          	ldw	x,_timenct
5339  001d 2703          	jreq	L5322
5342  001f 5a            	decw	x
5343  0020 bf1e          	ldw	_timenct,x
5344  0022               L5322:
5345                     ; 1300 	if (timemcp) timemcp--;
5347  0022 be20          	ldw	x,_timemcp
5348  0024 2703          	jreq	L7322
5351  0026 5a            	decw	x
5352  0027 bf20          	ldw	_timemcp,x
5353  0029               L7322:
5354                     ; 1301 	if (timeuv) timeuv--;
5356  0029 b622          	ld	a,_timeuv
5357  002b 2702          	jreq	L1422
5360  002d 3a22          	dec	_timeuv
5361  002f               L1422:
5362                     ; 1304 	if (timesec) timesec--;	
5364  002f be36          	ldw	x,_timesec
5365  0031 2703          	jreq	L3422
5368  0033 5a            	decw	x
5369  0034 bf36          	ldw	_timesec,x
5370  0036               L3422:
5371                     ; 1305 	if (timesec==0) {
5373  0036 be36          	ldw	x,_timesec
5374  0038 260b          	jrne	L5422
5375                     ; 1306 		timesec=1000;
5377  003a ae03e8        	ldw	x,#1000
5378  003d bf36          	ldw	_timesec,x
5379                     ; 1308 		if (timeshownext) timeshownext--;	
5381  003f b60f          	ld	a,_timeshownext
5382  0041 2702          	jreq	L5422
5385  0043 3a0f          	dec	_timeshownext
5386  0045               L5422:
5387                     ; 1312 	if (spiralpower==0) {
5389  0045 b611          	ld	a,_spiralpower
5390  0047 2609          	jrne	L1522
5391                     ; 1314 		GPIOA->ODR &= (uint8_t)(~GPIO_PIN_3);
5393  0049 72175000      	bres	20480,#3
5394                     ; 1315 		spiraltime=0;
5396  004d 5f            	clrw	x
5397  004e bf13          	ldw	_spiraltime,x
5398                     ; 1316 		spiralon=0;
5400  0050 2036          	jpf	LC025
5401  0052               L1522:
5402                     ; 1321 		spiraltime++;
5404  0052 be13          	ldw	x,_spiraltime
5405  0054 5c            	incw	x
5406  0055 bf13          	ldw	_spiraltime,x
5407                     ; 1324 		timeon = 2000 * spiralpower/100;
5409  0057 97            	ld	xl,a
5410  0058 a614          	ld	a,#20
5411  005a 42            	mul	x,a
5412  005b 1f03          	ldw	(OFST-1,sp),x
5414                     ; 1325 		timeoff = 2000 - timeon;
5416  005d ae07d0        	ldw	x,#2000
5417  0060 72f003        	subw	x,(OFST-1,sp)
5418  0063 1f01          	ldw	(OFST-3,sp),x
5420                     ; 1327 		if (spiralon) {
5422  0065 b612          	ld	a,_spiralon
5423  0067 2711          	jreq	L5522
5424                     ; 1329 			if (spiraltime > timeon) {
5426  0069 be13          	ldw	x,_spiraltime
5427  006b 1303          	cpw	x,(OFST-1,sp)
5428  006d 231b          	jrule	L3522
5429                     ; 1330 				spiraltime = 0;
5431  006f 5f            	clrw	x
5432  0070 bf13          	ldw	_spiraltime,x
5433                     ; 1331 				GPIOA->ODR &= (uint8_t)(~GPIO_PIN_3);
5435  0072 72175000      	bres	20480,#3
5436                     ; 1332 				spiralon = 0;				
5438  0076 3f12          	clr	_spiralon
5439  0078 2010          	jra	L3522
5440  007a               L5522:
5441                     ; 1334 		} else if (spiraltime > timeoff) {
5443  007a be13          	ldw	x,_spiraltime
5444  007c 1301          	cpw	x,(OFST-3,sp)
5445  007e 230a          	jrule	L3522
5446                     ; 1335 			spiraltime = 0;
5448  0080 5f            	clrw	x
5449  0081 bf13          	ldw	_spiraltime,x
5450                     ; 1336 			GPIOA->ODR |= GPIO_PIN_3;
5452  0083 72165000      	bset	20480,#3
5453                     ; 1337 			spiralon = 1;
5455  0087 4c            	inc	a
5456  0088               LC025:
5458  0088 b712          	ld	_spiralon,a
5459  008a               L3522:
5460                     ; 1341 	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
5462  008a a601          	ld	a,#1
5463  008c cd0000        	call	_TIM4_ClearITPendingBit
5465                     ; 1347 		if(kndtime) kndtime--;
5467  008f b61d          	ld	a,_kndtime
5468  0091 2704          	jreq	LC027
5471  0093 3a1d          	dec	_kndtime
5472                     ; 1348 		if (kndtime==0) {
5474  0095 2672          	jrne	L7622
5475  0097               LC027:
5476                     ; 1349 			u8 knall=0;
5478  0097 0f04          	clr	(OFST+0,sp)
5480                     ; 1352 			kndtime = KNDTIME;
5482  0099 3532001d      	mov	_kndtime,#50
5483                     ; 1354 			ADC1_StartConversion();
5485  009d cd0000        	call	_ADC1_StartConversion
5488  00a0               L3722:
5489                     ; 1355 			while( ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
5491  00a0 a680          	ld	a,#128
5492  00a2 cd0000        	call	_ADC1_GetFlagStatus
5494  00a5 4d            	tnz	a
5495  00a6 27f8          	jreq	L3722
5496                     ; 1356 			adcval = ADC1_GetConversionValue();
5498  00a8 cd0000        	call	_ADC1_GetConversionValue
5500  00ab bf3a          	ldw	_adcval,x
5501                     ; 1358 		  if (adcval < 10 )  {knall |= GPIO_PIN_0;}
5503  00ad a3000a        	cpw	x,#10
5504  00b0 2406          	jruge	L7722
5507  00b2 7b04          	ld	a,(OFST+0,sp)
5508  00b4 aa01          	or	a,#1
5510  00b6 201f          	jpf	LC026
5511  00b8               L7722:
5512                     ; 1359 		  else if (adcval < 550 )  {knall |= GPIO_PIN_1;}
5514  00b8 a30226        	cpw	x,#550
5515  00bb 2406          	jruge	L3032
5518  00bd 7b04          	ld	a,(OFST+0,sp)
5519  00bf aa02          	or	a,#2
5521  00c1 2014          	jpf	LC026
5522  00c3               L3032:
5523                     ; 1360 		  else if (adcval < 700 )  {knall |= GPIO_PIN_2;}
5525  00c3 a302bc        	cpw	x,#700
5526  00c6 2406          	jruge	L7032
5529  00c8 7b04          	ld	a,(OFST+0,sp)
5530  00ca aa04          	or	a,#4
5532  00cc 2009          	jpf	LC026
5533  00ce               L7032:
5534                     ; 1361 		  else if (adcval < 800 )  {knall |= GPIO_PIN_3;}
5536  00ce a30320        	cpw	x,#800
5537  00d1 2406          	jruge	L1032
5540  00d3 7b04          	ld	a,(OFST+0,sp)
5541  00d5 aa08          	or	a,#8
5542  00d7               LC026:
5543  00d7 6b04          	ld	(OFST+0,sp),a
5545  00d9               L1032:
5546                     ; 1363 			knall = ~knall;
5548  00d9 0304          	cpl	(OFST+0,sp)
5550                     ; 1365 			knint(0, knall, GPIO_PIN_0);
5552  00db 4b01          	push	#1
5553  00dd 7b05          	ld	a,(OFST+1,sp)
5554  00df 5f            	clrw	x
5555  00e0 97            	ld	xl,a
5556  00e1 cd0000        	call	_knint
5558  00e4 84            	pop	a
5559                     ; 1366 			knint(1, knall, GPIO_PIN_1);
5561  00e5 4b02          	push	#2
5562  00e7 7b05          	ld	a,(OFST+1,sp)
5563  00e9 ae0100        	ldw	x,#256
5564  00ec 97            	ld	xl,a
5565  00ed cd0000        	call	_knint
5567  00f0 84            	pop	a
5568                     ; 1367 			knint(2, knall, GPIO_PIN_2);
5570  00f1 4b04          	push	#4
5571  00f3 7b05          	ld	a,(OFST+1,sp)
5572  00f5 ae0200        	ldw	x,#512
5573  00f8 97            	ld	xl,a
5574  00f9 cd0000        	call	_knint
5576  00fc 84            	pop	a
5577                     ; 1368 			knint(3, knall, GPIO_PIN_3);
5579  00fd 4b08          	push	#8
5580  00ff 7b05          	ld	a,(OFST+1,sp)
5581  0101 ae0300        	ldw	x,#768
5582  0104 97            	ld	xl,a
5583  0105 cd0000        	call	_knint
5585  0108 84            	pop	a
5586  0109               L7622:
5587                     ; 1373 		for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
5589  0109 4f            	clr	a
5590  010a 6b04          	ld	(OFST+0,sp),a
5592  010c               L5132:
5595  010c 5f            	clrw	x
5596  010d 97            	ld	xl,a
5597  010e 58            	sllw	x
5598  010f e62b          	ld	a,(_kntime+1,x)
5599  0111 ea2a          	or	a,(_kntime,x)
5600  0113 2708          	jreq	L3232
5603  0115 9093          	ldw	y,x
5604  0117 ee2a          	ldw	x,(_kntime,x)
5605  0119 5a            	decw	x
5606  011a 90ef2a        	ldw	(_kntime,y),x
5607  011d               L3232:
5610  011d 0c04          	inc	(OFST+0,sp)
5614  011f 7b04          	ld	a,(OFST+0,sp)
5615  0121 a104          	cp	a,#4
5616  0123 25e7          	jrult	L5132
5617                     ; 1377  }
5620  0125 5b04          	addw	sp,#4
5621  0127 85            	popw	x
5622  0128 bf00          	ldw	c_y,x
5623  012a 320002        	pop	c_y+2
5624  012d 85            	popw	x
5625  012e bf00          	ldw	c_x,x
5626  0130 320002        	pop	c_x+2
5627  0133 80            	iret	
5655                     ; 1379  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
5655                     ; 1380  {
5656                     .text:	section	.text,new
5657  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
5659  0000 8a            	push	cc
5660  0001 84            	pop	a
5661  0002 a4bf          	and	a,#191
5662  0004 88            	push	a
5663  0005 86            	pop	cc
5664  0006 3b0002        	push	c_x+2
5665  0009 be00          	ldw	x,c_x
5666  000b 89            	pushw	x
5667  000c 3b0002        	push	c_y+2
5668  000f be00          	ldw	x,c_y
5669  0011 89            	pushw	x
5672                     ; 1384 	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
5674  0012 a601          	ld	a,#1
5675  0014 cd0000        	call	_TIM2_ClearITPendingBit
5677                     ; 1386 	OFF1;
5679  0017 4b20          	push	#32
5680  0019 ae500a        	ldw	x,#20490
5681  001c cd0000        	call	_GPIO_WriteLow
5683  001f 84            	pop	a
5684                     ; 1387 	OFF2;
5686  0020 4b40          	push	#64
5687  0022 ae500f        	ldw	x,#20495
5688  0025 cd0000        	call	_GPIO_WriteLow
5690  0028 84            	pop	a
5691                     ; 1388 	OFF3;
5693  0029 4b10          	push	#16
5694  002b ae500f        	ldw	x,#20495
5695  002e cd0000        	call	_GPIO_WriteLow
5697  0031 84            	pop	a
5698                     ; 1389 	ALLOFF
5700  0032 4bc0          	push	#192
5701  0034 ae500a        	ldw	x,#20490
5702  0037 cd0000        	call	_GPIO_WriteHigh
5704  003a 84            	pop	a
5707  003b 4b2c          	push	#44
5708  003d ae500f        	ldw	x,#20495
5709  0040 cd0000        	call	_GPIO_WriteHigh
5711  0043 84            	pop	a
5714  0044 4b06          	push	#6
5715  0046 ae5000        	ldw	x,#20480
5716  0049 cd0000        	call	_GPIO_WriteHigh
5718  004c 84            	pop	a
5719                     ; 1391 	if (numind<7) {
5721  004d b606          	ld	a,_numind
5722  004f a107          	cp	a,#7
5723  0051 2403          	jruge	L5332
5724                     ; 1392 		cifraS(numind);
5726  0053 cd0000        	call	_cifraS
5728  0056               L5332:
5729                     ; 1396 	numind++;
5731  0056 3c06          	inc	_numind
5732                     ; 1397 	if (numind==7) numind=0;
5734  0058 b606          	ld	a,_numind
5735  005a a107          	cp	a,#7
5736  005c 2602          	jrne	L7332
5739  005e 3f06          	clr	_numind
5740  0060               L7332:
5741                     ; 1398  }
5744  0060 85            	popw	x
5745  0061 bf00          	ldw	c_y,x
5746  0063 320002        	pop	c_y+2
5747  0066 85            	popw	x
5748  0067 bf00          	ldw	c_x,x
5749  0069 320002        	pop	c_x+2
5750  006c 80            	iret	
5773                     ; 1400 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
5773                     ; 1401 {
5774                     .text:	section	.text,new
5775  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
5779                     ; 1405 	if (TIM1->CCR1L) GPIOC->ODR |= GPIO_PIN_3;
5781  0000 725d5266      	tnz	21094
5782  0004 2706          	jreq	L1532
5785  0006 7216500a      	bset	20490,#3
5787  000a 2004          	jra	L3532
5788  000c               L1532:
5789                     ; 1406 	else GPIOC->ODR &= ~GPIO_PIN_3;
5791  000c 7217500a      	bres	20490,#3
5792  0010               L3532:
5793                     ; 1408 	TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT_UPDATE);
5795  0010 35fe5255      	mov	21077,#254
5796                     ; 1409 }
5799  0014 80            	iret	
5822                     ; 1413 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
5822                     ; 1414 {
5823                     .text:	section	.text,new
5824  0000               f_TIM1_CAP_COM_IRQHandler:
5828                     ; 1418 	if (TIM1->CCR1L!=MAXPWM) GPIOC->ODR &= (uint8_t)(~GPIO_PIN_3);
5830  0000 c65266        	ld	a,21094
5831  0003 a105          	cp	a,#5
5832  0005 2704          	jreq	L5632
5835  0007 7217500a      	bres	20490,#3
5836  000b               L5632:
5837                     ; 1419 	TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT_CC1);
5839  000b 35fd5255      	mov	21077,#253
5840                     ; 1420 }
5843  000f 80            	iret	
6292                     	xdef	f_TIM1_CAP_COM_IRQHandler
6293                     	switch	.ubsct
6294  0000               _tsttst:
6295  0000 00            	ds.b	1
6296                     	xdef	_tsttst
6297                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
6298                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
6299                     	xdef	f_TIM4_UPD_OVF_IRQHandler
6300                     	xdef	_timesec
6301                     	xdef	_knint
6302                     	xdef	_timedelay
6303                     	xdef	_main
6304                     	xdef	_showinfo
6305                     	xdef	_sleep
6306                     	xdef	_shownumber
6307                     	xdef	_cifraS
6308                     	xdef	_cifra
6309                     	xdef	_mcpdata
6310                     	xdef	_mcpinit
6311                     	xdef	_mypow
6312                     	xdef	_uvdata
6313                     	xdef	_uvinit
6314                     	xdef	_nctdata
6315                     	xdef	_nctinit
6316                     	xdef	_I2C_readnbyte
6317                     	xdef	_I2C_writenbyte
6318                     	xdef	_shift_and_mul_utoa16
6319                     	xdef	_PI_Regulator
6320  0001               _bmeT:
6321  0001 00000000      	ds.b	4
6322                     	xdef	_bmeT
6323  0005               _mcpT:
6324  0005 00000000      	ds.b	4
6325                     	xdef	_mcpT
6326                     	xdef	_cKf
6327                     	xdef	_cKm
6328                     	xdef	_cK
6329                     	xdef	_fansot
6330                     	xdef	_fandes
6331                     	xdef	_kn2old
6332                     	xdef	_kn1old
6333                     	xdef	_kn2
6334                     	xdef	_kn1
6335  0009               _buff:
6336  0009 000000000000  	ds.b	30
6337                     	xdef	_buff
6338  0027               _blueen:
6339  0027 00            	ds.b	1
6340                     	xdef	_blueen
6341                     	xdef	_current_millis
6342                     	xdef	_LSIMeasurment
6343                     	xdef	_Delay
6344  0028               _min:
6345  0028 00            	ds.b	1
6346                     	xdef	_min
6347  0029               _sec:
6348  0029 00            	ds.b	1
6349                     	xdef	_sec
6350                     	xdef	_rezhim
6351                     	xdef	_timeuv
6352                     	xdef	_timemcp
6353                     	xdef	_timenct
6354                     	xdef	_kndtime
6355  002a               _kntime:
6356  002a 000000000000  	ds.b	8
6357                     	xdef	_kntime
6358  0032               _knstatus:
6359  0032 00000000      	ds.b	4
6360                     	xdef	_knstatus
6361  0036               _kn:
6362  0036 00000000      	ds.b	4
6363                     	xdef	_kn
6364  003a               _adcval:
6365  003a 0000          	ds.b	2
6366                     	xdef	_adcval
6367                     	xdef	_hKi_Gain
6368                     	xdef	_hKp_Gain
6369                     	xdef	_wIntegral
6370                     	xdef	_spiraltime
6371                     	xdef	_spiralon
6372                     	xdef	_spiralpower
6373                     	xdef	_showind
6374                     	xdef	_timeshownext
6375                     	xdef	_tempold
6376                     	xdef	_temp
6377                     	xdef	_speedfanold
6378                     	xdef	_speedfan
6379                     	xdef	_fanold
6380                     	xdef	_fan
6381                     	xdef	_numind
6382                     	xdef	_tchk
6383                     	xdef	_ind
6384                     	xref	_TIM4_ClearITPendingBit
6385                     	xref	_TIM4_ClearFlag
6386                     	xref	_TIM4_ITConfig
6387                     	xref	_TIM4_Cmd
6388                     	xref	_TIM4_TimeBaseInit
6389                     	xref	_TIM2_ClearITPendingBit
6390                     	xref	_TIM2_ClearFlag
6391                     	xref	_TIM2_ITConfig
6392                     	xref	_TIM2_Cmd
6393                     	xref	_TIM2_TimeBaseInit
6394                     	xref	_TIM1_ClearFlag
6395                     	xref	_TIM1_GetCapture1
6396                     	xref	_TIM1_CCPreloadControl
6397                     	xref	_TIM1_ITConfig
6398                     	xref	_TIM1_CtrlPWMOutputs
6399                     	xref	_TIM1_Cmd
6400                     	xref	_TIM1_BDTRConfig
6401                     	xref	_TIM1_OC1Init
6402                     	xref	_TIM1_TimeBaseInit
6403                     	xref	_TIM1_DeInit
6404                     	xref	_I2C_GetFlagStatus
6405                     	xref	_I2C_CheckEvent
6406                     	xref	_I2C_Send7bitAddress
6407                     	xref	_I2C_ReceiveData
6408                     	xref	_I2C_AcknowledgeConfig
6409                     	xref	_I2C_GenerateSTOP
6410                     	xref	_I2C_Cmd
6411                     	xref	_I2C_Init
6412                     	xref	_GPIO_WriteLow
6413                     	xref	_GPIO_WriteHigh
6414                     	xref	_GPIO_Init
6415                     	xref	_CLK_GetClockFreq
6416                     	xref	_CLK_HSIPrescalerConfig
6417                     	xref	_ADC1_GetFlagStatus
6418                     	xref	_ADC1_GetConversionValue
6419                     	xref	_ADC1_StartConversion
6420                     	xref	_ADC1_Cmd
6421                     	xref	_ADC1_Init
6422                     	xref	_ADC1_DeInit
6423                     	switch	.const
6424  0080               L1421:
6425  0080 44000000      	dc.w	17408,0
6426                     	xref.b	c_lreg
6427                     	xref.b	c_x
6428                     	xref.b	c_y
6448                     	xref	c_ludv
6449                     	xref	c_uitolx
6450                     	xref	c_ftol
6451                     	xref	c_fgadd
6452                     	xref	c_fmul
6453                     	xref	c_ctof
6454                     	xref	c_fcmp
6455                     	xref	c_itof
6456                     	xref	c_fdiv
6457                     	xref	c_ltof
6458                     	xref	c_llsh
6459                     	xref	c_fgmul
6460                     	xref	c_lrsh
6461                     	xref	c_lor
6462                     	xref	c_ldiv
6463                     	xref	c_lcmp
6464                     	xref	c_lzmp
6465                     	xref	c_ladd
6466                     	xref	c_ltor
6467                     	xref	c_lmul
6468                     	xref	c_rtol
6469                     	xref	c_itolx
6470                     	end
