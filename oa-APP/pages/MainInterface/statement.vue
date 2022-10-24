<template>
	<view>
		<view>
			<!-- 公司选择器 -->
			<picker @change="changeCompany($event)" :range="companyList">
				<uni-nav-bar :title="companyList[chooseCompany]+'▼'" backgroundColor="#F8F8F8" />
			</picker>
		</view>
		<swiper :style="{height:screenheight+'px',backgroundColor:'#ffffff'}" :current="currentSwiper" indicator-dots
			circular @change="changeSwiper">
			<swiper-item v-for="(item,index) in companyList">
				<view class="horizontalCenter">
					<view class="swiperItem" :style="{height:screenheight*17/20+'px',marginTop:screenheight*1/20+'px'}">
						<view class="horizontalCenter">
							<uni-segmented-control class="segmentdControl" :current="timeCurrent" :values="timeItems"
								styleType="button" activeColor="#007aff" @clickItem="chooseTimeItems">
							</uni-segmented-control>
							<view class="content">
								<view v-show="timeCurrent === 0">
									<view>
										<uni-row>
											<uni-col class="timeTitle horizontalCenter">
												选择日期:
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col class="horizontalCenter">
												<dyDatePicker class="datePicker horizontalCenter" :childValue="nowDate"
													placeholder="请选择日期" :maxSelect="nowDate" @getData="getData">
												</dyDatePicker>
											</uni-col>
										</uni-row>
									</view>
									<view>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">收入:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{revenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{expenditures}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">利润:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">
													{{Math.round((revenue-expenditures)*100)/100}}</view>
											</uni-col>
										</uni-row>
									</view>
								</view>
								<view v-show="timeCurrent === 1">
									<view>
										<uni-row>
											<uni-col class="timeTitle horizontalCenter">
												选择月份:
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col class="horizontalCenter">
												<dyDatePicker timeType="month" class="datePicker horizontalCenter"
													:childValue="nowDate" laceholder="请选择月份" :maxSelect="nowDate"
													@getData="getData">
												</dyDatePicker>
											</uni-col>
										</uni-row>
									</view>
									<view>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">收入:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{revenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{expenditures}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">利润:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">
													{{Math.round((revenue-expenditures)*100)/100}}</view>
											</uni-col>
										</uni-row>
									</view>
								</view>
								<view v-show="timeCurrent === 2">
									<view>
										<uni-row>
											<uni-col class="timeTitle horizontalCenter">
												选择年份、季度:
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col :span="12" class="horizontalCenter">
												<dyDatePicker timeType="year" class="datePicker horizontalCenter" :childValue="nowDate"
													placeholder="请选择年份" :maxSelect="nowDate" @getData="getData">
<!-- 													placeholder="请选择年份" :maxSelect="nowDate" @getData="getYearData"> -->
												</dyDatePicker>
											</uni-col>
											<uni-col :span="12" class="horizontalCenter">
												<picker class="datePicker horizontalCenter" :value="currentSeason"
													@change="chooseSeason($event)" :range="seasonList">
													<view>{{seasonList[currentSeason]}}</view>
												</picker>
											</uni-col>
										</uni-row>
									</view>
									<view>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">收入:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{revenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{expenditures}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">利润:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">
													{{Math.round((revenue-expenditures)*100)/100}}</view>
											</uni-col>
										</uni-row>
									</view>
								</view>
								<view v-show="timeCurrent === 3">
									<view>
										<uni-row>
											<uni-col class="timeTitle horizontalCenter">
												选择年份:
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col class="horizontalCenter">
												<dyDatePicker timeType="year" class="datePicker horizontalCenter" :childValue="nowDate"
													placeholder="请选择年份" :maxSelect="nowDate" @getData="getData">
												</dyDatePicker>
											</uni-col>
										</uni-row>
									</view>
									<view>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">收入:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{revenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{expenditures}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">利润:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">
													{{Math.round((revenue-expenditures)*100)/100}}</view>
											</uni-col>
										</uni-row>
									</view>
								</view>
							</view>
						</view>
					</view>
				</view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
	import dyDatePicker from '../../components/dy-Date/dy-Date.vue'
	export default {
		components: {
			dyDatePicker
		},
		data() {
			return {
				screenheight: 0,
				chooseCompany: 0,
				currentSwiper: 0,
				timeItems: ['日', '月', '季', '年'],
				timeCurrent: 0,
				nowDate: "",
				revenue: 0,
				expenditures: 0,
				// chooseYearTF: true,
				// chooseSeasonTF: true,
				currentSeason:0,
				seasonList:["1,2,3月","4,5,6月","7,8,9月","10,11,12月"],
				companyList: ["总体", "广西永湘物流有限公司", "广西南宁锦泰行工贸有限公司", "广西丰沣顺国际物流有限公司"]
			}
		},
		onLoad() {
			// 动态设置导航栏标题
			uni.setNavigationBarTitle({
				title: this.companyList[0].companyName
			});
			this.screenheight = this.getscreenheight();

			this.nowDate = new Date().toISOString().slice(0, 10);

			this.setNumber();
		},
		methods: {
			getscreenheight() {
				var resultheight = 0;
				uni.getSystemInfo({
					success: function(res) {
						console.log(res.windowHeight);
						resultheight = res.windowHeight - 45
					}
				});
				console.log(resultheight);
				return resultheight;
			},
			changeCompany(e) {
				this.chooseCompany = e.detail.value;
				this.currentSwiper = this.chooseCompany;
				this.setNumber();
			},
			changeSwiper(e) {
				this.chooseCompany = e.detail.current;
				this.setNumber();
			},
			chooseTimeItems(e) {
				if (this.timeCurrent != e.currentIndex) {
					this.timeCurrent = e.currentIndex;
				}
				this.setNumber();
			},
			getData(time) {
				console.log(time);
				this.setNumber();
			},
			// getYearData(time) {
			// 	console.log(time);
				// this.chooseYearTF=true;
				// if(this.chooseSeasonTF==true){
					// this.setNumber();
				// }
			// },
			setNumber() {
				this.revenue = this.getRandom(10000, 100000);
				this.expenditures = this.getRandom(10000, this.revenue);
				console.log(this.revenue);
				console.log(this.expenditures);
			},
			getRandom(min, max) {
				var temp = max - min;
				var random = Math.random();
				var num = Math.round((min + Math.round(random * temp * 100) / 100) * 100) / 100;
				return num;
			},
			chooseSeason(e){
				console.log(e);
				this.currentSeason=e.detail.value;
				// this.chooseSeasonTF=true;
				// if(this.chooseYearTF==true){
					this.setNumber();
				// }
			}
		}
	}
</script>

<style>
	@font-face {
		font-family: 'UnidreamLED';
		src: url(/static/fontUtil/UnidreamLED.eot);
		/***兼容ie9***/
		src: url(/static/fontUtil/UnidreamLED.eot)format('embedded-opentype'),
			/***兼容ie6-ie8***/
			url('/static/fontUtil/UnidreamLED.woff') format('woff'),
			local('UnidreamLED'), url("/static/fontUtil/UnidreamLED.woff");
		/***默认使用本地的***/
	}

	.navbarGroup {
		background-color: #F8F8F8;
		font-size: 16px;
	}

	.horizontalCenter {
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.swiperItem {
		width: 84%;
		border: #00ffff solid 10rpx;
		background-color: #ffffff;
		box-shadow: -5rpx 5rpx 15rpx #00ffff;
		border-radius: 3%;
	}

	.segmentdControl {
		margin-top: 30rpx;
		margin-bottom: 30rpx;
		width: 70%;
	}

	.timeTitle {
		font-size: 30rpx;
		color: #007aff;
	}

	.datePicker {
		font-size: 33rpx;
		color: #007aff;
		border-radius: 10rpx;
		border: #00ffff solid 5rpx;
		margin-top: 10rpx;
		margin-bottom: 40rpx;
		width: 200rpx;
		height: 40rpx;
	}

	.bigTitle {
		font-size: 42rpx;
		color: #007aff;
	}

	.number {
		color: #009999;
		font-family: 'UnidreamLED';
		height: 150rpx;
		font-size: 100rpx;
	}
</style>
