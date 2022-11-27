<template>
	<view>
		<view :style="{marginTop:statusBarHeight+'px'}">
			<!-- 公司选择器 -->
			<picker @change="changeCompany($event)" :range="companyList">
				<uni-nav-bar :title="companyList[chooseCompany]+'▼'" backgroundColor="#F8F8F8" />
			</picker>
		</view>
		<swiper :style="{height:screenheight-statusBarHeight+'px',backgroundColor:'#ffffff'}" :current="currentSwiper" indicator-dots
			circular @change="changeSwiper">
			<swiper-item v-for="(item,index) in companyList">
				<view class="horizontalCenter">
					<view class="swiperItem" :style="{height:(screenheight-statusBarHeight)*17/20+'px',marginTop:screenheight*1/20+'px'}">
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
												<dyDatePicker class="datePicker horizontalCenter" :childValue="choosedDay"
													placeholder="请选择日期" :maxSelect="nowDate" @getData="chooseDate">
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
												<view class="number horizontalCenter">{{dayRevenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{daySpend}}</view>
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
													{{Math.round((dayRevenue-daySpend)*100)/100}}</view>
											</uni-col>
										</uni-row>
										<view v-show="currentSwiper==0" style="marginTop:50rpx">
											<uni-row>
												<uni-col>
													<view class="bigTitle horizontalCenter" style="color: #ff007f">办公支出:</view>
												</uni-col>
											</uni-row>
											<uni-row>
												<uni-col>
													<view class="officeNumber horizontalCenter">
														{{dayOfficeSpending}}</view>
												</uni-col>
											</uni-row>
										</view>
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
													:childValue="choosedMonth" laceholder="请选择月份" :maxSelect="nowDate"
													@getData="chooseDate">
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
												<view class="number horizontalCenter">{{monthRevenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{monthSpend}}</view>
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
													{{Math.round((monthRevenue-monthSpend)*100)/100}}</view>
											</uni-col>
										</uni-row>
										<view v-show="currentSwiper==0" style="marginTop:50rpx">
											<uni-row>
												<uni-col>
													<view class="bigTitle horizontalCenter" style="color: #ff007f">办公支出:</view>
												</uni-col>
											</uni-row>
											<uni-row>
												<uni-col>
													<view class="officeNumber horizontalCenter">
														{{monthOfficeSpending}}</view>
												</uni-col>
											</uni-row>
										</view>
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
												<dyDatePicker timeType="year" class="datePicker horizontalCenter" :childValue="choosedSYear"
													placeholder="请选择年份" :maxSelect="nowDate" @getData="chooseDate">
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
												<view class="number horizontalCenter">{{seasonRevenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{seasonSpend}}</view>
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
													{{Math.round((seasonRevenue-seasonSpend)*100)/100}}</view>
											</uni-col>
										</uni-row>
										<view v-show="currentSwiper==0" style="marginTop:50rpx">
											<uni-row>
												<uni-col>
													<view class="bigTitle horizontalCenter" style="color: #ff007f">办公支出:</view>
												</uni-col>
											</uni-row>
											<uni-row>
												<uni-col>
													<view class="officeNumber horizontalCenter">
														{{seasonOfficeSpending}}</view>
												</uni-col>
											</uni-row>
										</view>
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
												<dyDatePicker timeType="year" class="datePicker horizontalCenter" :childValue="choosedYear"
													placeholder="请选择年份" :maxSelect="nowDate" @getData="chooseDate">
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
												<view class="number horizontalCenter">{{yearRevenue}}</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="bigTitle horizontalCenter">支出:</view>
											</uni-col>
										</uni-row>
										<uni-row>
											<uni-col>
												<view class="number horizontalCenter">{{yearSpend}}</view>
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
													{{Math.round((yearRevenue-yearSpend)*100)/100}}</view>
											</uni-col>
										</uni-row>
										<view v-show="currentSwiper==0" style="marginTop:50rpx">
											<uni-row>
												<uni-col>
													<view class="bigTitle horizontalCenter" style="color: #ff007f">办公支出:</view>
												</uni-col>
											</uni-row>
											<uni-row>
												<uni-col>
													<view class="officeNumber horizontalCenter">
														{{yearOfficeSpending}}</view>
												</uni-col>
											</uni-row>
										</view>
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
				statusBarHeight:0,
				chooseCompany: 0,
				currentSwiper: 0,
				timeItems: ['日', '月', '季', '年'],
				timeCurrent: 0,
				nowDate: '',
				currentSeason:0,
				seasonList:["第一季度","第二季度","第三季度","第四季度"],
				companyList: ["总体", "广西永湘物流有限公司", "广西南宁锦泰行工贸有限公司", "广西丰沣顺国际物流有限公司"],
				choosedDay:'',
				choosedMonth:'',
				choosedSYear:'',
				choosedSSeason:'',
				choosedYear:'',
				// revenue: 0,
				// spend: 0,
				// officeSpending:0,
				dayRevenue: 0,
				daySpend: 0,
				dayOfficeSpending:0,
				monthRevenue: 0,
				monthSpend: 0,
				monthOfficeSpending:0,
				seasonRevenue: 0,
				seasonSpend: 0,
				seasonOfficeSpending:0,
				yearRevenue: 0,
				yearSpend: 0,
				yearOfficeSpending:0,
			}
		},
		onLoad() {
			// 动态设置导航栏标题
			uni.setNavigationBarTitle({
				title: this.companyList[0].companyName
			});
			this.getscreenheight();
			
			// 获取当前日期,转换为ISO会丢失时区，所以需要加8小时
			this.nowDate = new Date(+new Date()+8*3600*1000).toISOString().slice(0, 10);
			this.choosedDay=this.nowDate;
			this.choosedMonth=this.nowDate.slice(0,7);
			this.choosedSYear=this.nowDate.slice(0,4);
			this.choosedSSeason=this.getSeason(this.nowDate.slice(5,7));
			this.choosedYear=this.nowDate.slice(0,4);
			this.setNumber(0,this.choosedDay);
			this.setNumber(1,this.choosedMonth);
			this.setNumber(2,this.choosedSYear+this.choosedSSeason);
			this.setNumber(3,this.choosedYear);
		},
		methods: {
			getscreenheight() {
				var resultheight = 0;
				const that=this;
				uni.getSystemInfo({
					success: function(res) {
						console.log(res.windowHeight);
						console.log(res.statusBarHeight);
						that.statusBarHeight=res.statusBarHeight;
						that.screenheight=res.windowHeight-45;
					}
				});
				console.log(resultheight);
			},
			changeCompany(e) {
				this.chooseCompany = e.detail.value;
				this.currentSwiper = this.chooseCompany;
				this.getNewData();
			},
			changeSwiper(e) {
				this.chooseCompany = e.detail.current;
				this.currentSwiper=this.chooseCompany;
				this.getNewData();
			},
			chooseTimeItems(e) {
				if (this.timeCurrent != e.currentIndex) {
					this.timeCurrent = e.currentIndex;
					// this.getNewData();
				}
			},
			getNewData(){
				if(this.timeCurrent==0){
					this.setNumber(0,this.choosedDay);
				}else if(this.timeCurrent==1){
					this.setNumber(1,this.choosedMonth);
				}else if(this.timeCurrent==2){
					this.setNumber(2,this.choosedSYear+this.choosedSSeason)
				}else if(this.timeCurrent==3){
					this.setNumber(3,this.choosedYear);
				}
			},
			chooseDate(time) {
				console.log(time);
				if(this.timeCurrent==0){
					this.choosedDay=time;
					this.setNumber(0,this.choosedDay);
				}else if(this.timeCurrent==1){
					this.choosedMonth=time;
					this.setNumber(1,this.choosedMonth);
				}else if(this.timeCurrent==2){
					this.choosedSYear=time;
					if(this.choosedSSeason!=''){
						this.setNumber(2,this.choosedSYear+this.choosedSSeason);
					}
				}else if(this.timeCurrent==3){
					this.choosedYear=time;
					this.setNumber(3,this.choosedYear);
				}
			},
			chooseSeason(e){
				this.currentSeason=e.detail.value;
				if(e.detail.value==0){
					this.choosedSSeason="-1"
				}else if(e.detail.value==1){
					this.choosedSSeason="-2"
				}else if(e.detail.value==2){
					this.choosedSSeason="-3"
				}else if(e.detail.value==3){
					this.choosedSSeason="-4"
				}
				if(this.choosedSYear!=''){
					this.setNumber(2,this.choosedSYear+this.choosedSSeason);
				}
			},
			getSeason(time){
				if(time<4){
					this.currentSeason=0;
					return '-1'
				}else if(time<7){
					this.currentSeason=1;
					return '-2'
				}else if(time<10){
					this.currentSeason=2;
					return '-3'
				}else if(time<13){
					this.currentSeason=3;
					return '-4'
				}
			},
			getBusinessData(timeType,date){
				this.$request({
					url: '/finance/getChartIncomeSpendData',
					data: {
						dataType: 0,
						dataCompany:this.chooseCompany,
						timeType:timeType,
						startDate:date,
						endDate:date,
					}
				}).then(res => {
					if (res.code == 200) {
						if(res.data[0]!=null){
							if(res.data[0].income!=null){
								if(timeType==0){
									this.dayRevenue=res.data[0].income;
								}else if(timeType==1){
									this.monthRevenue=res.data[0].income;
								}else if(timeType==2){
									this.seasonRevenue=res.data[0].income;
								}else if(timeType==3){
									this.yearRevenue=res.data[0].income;
								}
							}else{
								if(timeType==0){
									this.dayRevenue=0;
								}else if(timeType==1){
									this.monthRevenue=0;
								}else if(timeType==2){
									this.seasonRevenue=0;
								}else if(timeType==3){
									this.yearRevenue=0;
								}
							}
							if(res.data[0].spend!=null){
								if(timeType==0){
									this.daySpend=res.data[0].spend;
								}else if(timeType==1){
									this.monthSpend=res.data[0].spend;
								}else if(timeType==2){
									this.seasonSpend=res.data[0].spend;
								}else if(timeType==3){
									this.yearSpend=res.data[0].spend;
								}
							}else{
								if(timeType==0){
									this.daySpend=0;
								}else if(timeType==1){
									this.monthSpend=0;
								}else if(timeType==2){
									this.seasonSpend=0;
								}else if(timeType==3){
									this.yearSpend=0;
								}
							}
						}else{
							if(timeType==0){
								this.dayRevenue=0;
								this.daySpend=0;
							}else if(timeType==1){
								this.monthRevenue=0;
								this.monthSpend=0;
							}else if(timeType==2){
								this.seasonRevenue=0;
								this.seasonSpend=0;
							}else if(timeType==3){
								this.yearRevenue=0;
								this.yearSpend=0;
							}
						}
					}
				}, err => {
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				});
			},
			getOfficeData(timeType,date){
				this.$request({
					url: '/finance/getChartIncomeSpendData',
					data: {
						dataType: 1,
						dataCompany:this.chooseCompany,
						timeType:timeType,
						startDate:date,
						endDate:date,
					}
				}).then(res => {
					if (res.code == 200) {
						if(res.data[0]!=null){
							if(res.data[0].spend!=null){
								this.officeSpending=res.data[0].spend
							}else{
								this.officeSpending=0
							}
						}
					}
				}, err => {
					uni.showModal({
						content: "请求服务失败",
						showCancel: false
					})
				})
			},
			setNumber(timeType,date) {
				console.log(timeType,date);
				if(this.chooseCompany==0){
					this.getBusinessData(timeType,date);
					this.getOfficeData(timeType,date);
				}else{
					this.getBusinessData(timeType,date);
				}
			},
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
		color: #009999;
	}

	.number {
		color: #009999;
		font-family: 'UnidreamLED';
		height: 150rpx;
		font-size: 100rpx;
	}
	
	.officeNumber{
		color: #aaaa7f;
		font-family: 'UnidreamLED';
		height: 150rpx;
		font-size: 100rpx;
	}
</style>
