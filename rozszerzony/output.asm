	jump.i #lab0
sum:
	enter.i #4
	add.i *BP+16,*BP+12,BP-4
	mov.i BP-4,*BP+8
	leave
	return
lab0:
	mov.i #1,24
	push.i #24
	mov.i #2,28
	push.i #28
	push.i #32
	call.i #sum
	incsp.i #12
	mov.i #3,36
	push.i #36
	mov.i #4,40
	push.i #40
	push.i #44
	call.i #sum
	incsp.i #12
	push.i #32
	push.i #44
	push.i #48
	call.i #sum
	incsp.i #12
	write.i 48
	exit
