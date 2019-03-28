<template>
	<div>
		<div class="controlArea">
			<button @click="reset()" :class="{ 'isDisabled': !start }">RESET</button>
			<button @click="back()" :class="{ 'isDisabled': !hasHistory }">BACK</button>
		</div>
		<div class="board" :style="{ width: 50*col+'px' }">
			<Box
				v-for="(x,index) in arr"
				:value="x"
				:key="index"
				:win="matcharr.indexOf(index)> -1"
				@fill="fill(index)"
			></Box>
			<!-- <h1>Time: {{ time || 0 }}s left</h1> -->
			<div>
				<div
					class="playerNotification player-1"
					:class="{ 'isActive': player == 1 }"
					v-if="!end"
				>PLAYER 1</div>
				<div
					class="playerNotification player-2"
					:class="{ 'isActive': player == 2 }"
					v-if="!end"
				>PLAYER 2</div>
			</div>
			<div class="messageNotification" v-if="end">PLAYER {{ player }} WIN</div>
		</div>
	</div>
</template>

<script>
import Box from "./Box.vue";

export default {
	name: "Board",
	components: {
		Box
	},
	data: function() {
		return {
			player: 1,
			end: false,
			max: 5,
			timeAllow: 5,
			currentStep: 0,
			time: this.timeAllow,
			start: false,
			matcharr: [],
			arr: this.initarr()
		};
	},
	computed: {
		hasHistory: function() {
			return this.currentStep > 0;
		}
	},
	methods: {
		initarr: function() {
			this.col = 10;
			var arr = new Array(this.col * this.col).fill(0);
			this.tmp = [{ player: 1, arr: [...arr] }];
			return arr;
		},
		fill: function(i) {
			if (!this.end) {
				var flag = false;
				this.arr.map((value, index) => {
					if (i == index && value === 0) {
					flag = true;
					this.arr[index] = this.player;
					}
				});
				if (flag) {
					//   this.resetTimer();
					//   this.startTimer();
					this.start = true;
					if (!this.isWin()) {
					this.currentStep += 1;
					this.player = this.player === 1 ? 2 : 1;
					var newtmp = { player: this.player, arr: [...this.arr] };
					this.tmp.push(newtmp);
					} else {
						this.end = true;
					}
				}
			} else {
			// this.resetTimer();
			}
		},
		isWin: function() {
			var win = false;
			// CHECK ROW
			for (var i = 0, len = this.arr.length / this.col; i < len; i++) {
				var inRow = this.arr.slice(i * this.col, i * this.col + this.col);
				var reg = "(1{" + this.max + "}|2{" + this.max + "})";
				reg = new RegExp(reg, "igm");
				if (inRow.join("").match(reg)) {
					var index = reg.exec(inRow.join(""));
					var row = i,
					x0 = index.index;
					var matcharr = [];
					for (var j = 0; j < this.max; j++) {
						matcharr.push(row * this.col + x0 + j);
					}
					this.matcharr = matcharr;
					win = true;
				}
			}
			// CHECK COLUMN
			var regcol01 = "1",
			regcol02 = "2";
			for (var i = 1; i < this.max; i++) {
				regcol01 += ".{" + (this.col - 1) + "}1";
				regcol02 += ".{" + (this.col - 1) + "}2";
			}
			var regcol = "(" + regcol01 + "|" + regcol02 + ")";
			regcol = new RegExp(regcol, "g");
			if (this.arr.join("").match(regcol)) {
				var index = regcol.exec(this.arr.join(""));
				var y0 = index.index;
				var matcharr = [];
				for (var j = 0; j < this.max; j++) {
					matcharr.push(y0 + this.col * j);
				}
				this.matcharr = matcharr;
				win = true;
			}
			// CHECK CROSS
			var regcross01 = `^((.{${this.col}})*(.{0,${this.col - this.max}}))1`,
			regcross02 = `^((.{${this.col}})*(.{0,${this.col - this.max}}))2`, 
			regcross11 = `^((.{${this.col}})*(.{${this.max - 1},${this.col - 1}}))1`,
			regcross12 = `^((.{${this.col}})*(.{${this.max - 1},${this.col - 1}}))2`;
			for (var i = 1; i < this.max; i++) {
				regcross01 += ".{" + this.col + "}1";
				regcross02 += ".{" + this.col + "}2";
				regcross11 += ".{" + (this.col - 2) + "}1";
				regcross12 += ".{" + (this.col - 2) + "}2";
			}
			var regcross0 = "(" + regcross01 + "|" + regcross02 + ")";
			var regcross1 = "(" + regcross11 + "|" + regcross12 + ")";
			regcross0 = new RegExp(regcross0, "g");
			regcross1 = new RegExp(regcross1, "g");
			if (this.arr.join("").match(regcross0)) {
				var index = regcross0.exec(this.arr.join(""));
				var z0 = index[2] ? index[2].length : 0;
				var matcharr = [];
				for (var j = 0; j < this.max; j++) {
					matcharr.push(z0 + this.col * j + j);
				}
				this.matcharr = matcharr;
				win = true;
			}
			if (this.arr.join("").match(regcross1)) {
				var index = regcross1.exec(this.arr.join(""));
				var z1 = index[5] ? index[5].length : 0;
				var matcharr = [];
				for (var j = 0; j < this.max; j++) {
					matcharr.push(z1 + this.col * j - j);
				}
				this.matcharr = matcharr;
				win = true;
			}
			return win;
		},
		reset: function() {
			this.arr = this.initarr();
			this.end = false;
			this.player = 1;
			this.currentStep = 0;
			this.start = false;
			// this.resetTimer();
			this.matcharr = [];
		},
		back: function() {
			if (this.currentStep > 0 && this.end === false) {
				// this.resetTimer();
				// this.startTimer();
				this.currentStep -= 1;
				this.arr = this.tmp[this.currentStep].arr;
				this.player = this.tmp[this.currentStep].player;
				this.tmp.pop();
			} else {
				return false;
			}
		},
		startTimer: function() {
			var self = this;
			this.time = this.timeAllow;
			this.cd = setInterval(function() {
			if (self.time > 0) {
				self.time -= 1;
			} else {
				self.random();
			}
			}, 1000);
		},
		resetTimer: function() {
			this.time = 0;
			clearInterval(this.cd);
		},
		random: function() {
			var self = this;
			var emptyarr = [];
			this.arr.map((v, i) => {
			if (v === 0) {
				emptyarr.push(i);
			}
			});
			var random = Math.round(Math.random() * emptyarr.length);
			var index = emptyarr[random];
			self.fill(index);
		}
	}
};
</script>
