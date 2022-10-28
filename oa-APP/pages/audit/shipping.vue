<template>
	<view>
		<view class="topBackGround">
			<view class="nullBG">
				&nbsp;
			</view>
		</view>
		<view class="topCard">
			<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="topCardClick">
				<uni-grid-item v-for="(item, index) in topList" :index="index" :key="index">
					<view class="topCardItem">
						<view class="topCardItemBorder" :style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
							<text class="count"
								:style="{'color':index==chooseForm?'#ff0000':'#0081ff','fontSize':index==chooseForm?'65rpx':'50rpx'}">{{item.count}}</text>
							<text class="tips"
								:style="{'color':index==chooseForm?'#ff0000':'#0081ff','fontSize':index==chooseForm?'28rpx':'','fontWeight':index==chooseForm?'bolder':''}">{{item.tips}}</text>
						</view>
					</view>
				</uni-grid-item>
			</uni-grid>
		</view>
		<view class="searchBox">
			<uni-search-bar v-model="searchValue" placeholder="请输入要搜索的内容" bgColor="#ffffff" :focus="false"
				@confirm="searchClick">
			</uni-search-bar>
		</view>
		<view v-show="chooseForm==0" v-for="(item,index) in unauditedList" :key="item.contractNo" class="formCard">
			<uni-transition custom-class="transition" :duration=500 :mode-class="item.modeClass" :show="item.show">
				<uni-card style="box-shadow: 5rpx 5rpx 15rpx #00ffff" title="海运物流单" :subTitle="item.contractNo"
					:extra="item.carrierCompanyName">
					<view class="cardContent">
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								集装箱号 :
							</uni-col>
							<uni-col :span="16">
								{{item.containerNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								铅封号 :
							</uni-col>
							<uni-col :span="16">
								{{item.sealNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								费用 :
							</uni-col>
							<uni-col :span="16">
								{{item.expenses}}
							</uni-col>
						</uni-row>
					</view>
					<view class="auditStatusGroup">
						<view v-for="(statusItem,statusIndex) in directorList" :key="statusItem.directorId"
							class="auditStatusItem">
							<view>{{statusItem.directorName}}</view>
							<view v-show="statusIndex==0">
								<uni-icons :style="'margin-left:15rpx'"
									:type="item.firstState === 0 ? '' : item.firstState===1?'checkmarkempty':'closeempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
							<view v-show="statusIndex==1">
								<uni-icons :style="'margin-left:15rpx'"
									:type="item.secondState === 0 ? '' : item.secondState===1?'checkmarkempty':'closeempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
							<view v-show="statusIndex==2">
								<uni-icons :style="'margin-left:15rpx'"
									:type="item.thridState === 0 ? '' : item.thridState===1?'checkmarkempty':'closeempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
						</view>
					</view>
					<view slot="actions" class="actionGroup">
						<view class="actionGroupItem" @tap="actionsClick('pass',item,index)">
							<button class="buttonGroup" type="primary">通过</button>
						</view>
<!-- 						<view class="actionGroupItem" @tap="actionsClick('refuse',item,index)">
							<button class="buttonGroup" type="warn">拒绝</button>
						</view> -->
						<view class="actionGroupItem" @tap="actionsClick('more',item,index)">
							<button class="buttonGroup">详情</button>
						</view>
					</view>
				</uni-card>
			</uni-transition>
		</view>
		<view v-show="chooseForm==1" v-for="(item,index) in auditedList" :key="item.contractNo" class="formCard">
				<uni-card style="box-shadow: 5rpx 5rpx 15rpx #00ffff" title="海运物流单" :subTitle="item.contractNo"
					:extra="item.carrierCompanyName">
					<view class="cardContent">
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								集装箱号 :
							</uni-col>
							<uni-col :span="16">
								{{item.containerNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								铅封号 :
							</uni-col>
							<uni-col :span="16">
								{{item.sealNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								费用 :
							</uni-col>
							<uni-col :span="16">
								{{item.expenses}}
							</uni-col>
						</uni-row>
					</view>
					<view class="auditStatusGroup">
						<view v-for="(statusItem,statusIndex) in directorList" :key="statusItem.directorId"
							class="auditStatusItem">
							<view>{{statusItem.directorName}}</view>
							<view v-show="statusIndex==0">
								<uni-icons :style="'margin-left:15rpx'"
									:type="item.firstState === 0 ? '' : item.firstState===1?'checkmarkempty':'closeempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
							<view v-show="statusIndex==1">
								<uni-icons :style="'margin-left:15rpx'"
									:type="item.secondState === 0 ? '' : item.secondState===1?'checkmarkempty':'closeempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
							<view v-show="statusIndex==2">
								<uni-icons :style="'margin-left:15rpx'"
									:type="item.thridState === 0 ? '' : item.thridState===1?'checkmarkempty':'closeempty'"
									size="24" color="#0081ff"></uni-icons>
							</view>
						</view>
					</view>
					<view slot="actions" class="actionGroup">
						<view class="actionGroupItem" @tap="actionsClick('more',item,index)">
							<button class="buttonGroup">详情</button>
						</view>
					</view>
				</uni-card>
		</view>
		<view v-show="chooseForm==2" v-for="(item,index) in completedList" :key="item.contractNo" class="formCard">
				<uni-card style="box-shadow: 5rpx 5rpx 15rpx #00ffff" title="海运物流单" :subTitle="item.contractNo"
					:extra="item.carrierCompanyName">
					<view class="cardContent">
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								集装箱号 :
							</uni-col>
							<uni-col :span="16">
								{{item.containerNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								铅封号 :
							</uni-col>
							<uni-col :span="16">
								{{item.sealNo}}
							</uni-col>
						</uni-row>
						<uni-row style="width: 100%;">
							<uni-col :span="8">
								费用 :
							</uni-col>
							<uni-col :span="16">
								{{item.expenses}}
							</uni-col>
						</uni-row>
					</view>
					<view slot="actions" class="actionGroup">
						<view class="actionGroupItem" @tap="actionsClick('more',item,index)">
							<button class="buttonGroup">详情</button>
						</view>
					</view>
				</uni-card>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				searchValue: "",
				directorList: [{
						directorId: "00001",
						directorName: "黄佳森"
					},
					{
						directorId: "00002",
						directorName: "谢晓东"
					},
					{
						directorId: "00003",
						directorName: "林国丰"
					}
				],
				topList: [{
						count: 17,
						tips: "待审批"
					},
					{
						count: 12,
						tips: "已审批"
					},
					{
						count: 14,
						tips: "已完成"
					}
				],
				chooseForm: 0,
				unauditedList: [{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
						firstState: 0,
						secondState: 1,
						thridState: 0,
						show: true,
						modeClass: 'fade'
					},
					{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
						firstState: 0,
						secondState: 1,
						thridState: 0,
						show: true,
						modeClass: 'fade'
					},
					{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
						firstState: 0,
						secondState: 1,
						thridState: 1,
						show: true,
						modeClass: 'fade'
					}
				],
				auditedList: [{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
						firstState: 1,
						secondState: 1,
						thridState: 0,
					},
					{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
						firstState: 1,
						secondState: 0,
						thridState: 1,
					},
					{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
						firstState: 1,
						secondState: 1,
						thridState: 0,
					}
				],
				completedList: [{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
					},
					{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
					},
					{
						contractNo: "TR00272839456",
						carrierCompanyName: "东方海外货柜航运有限公司",
						containerNo: "EASU9809490",
						sealNo: "C56765",
						expenses: 13888,
					}
				]
			}
		},
		onLoad(data) {
			console.log(data);
			if(data.chooseForm==1){
				this.chooseForm=1;
			}else if(data.chooseForm==2){
				this.chooseForm=2;
			}
		},
		onNavigationBarButtonTap(){
			uni.switchTab({
				url:"/pages/MainInterface/audit"
			})
		},
		onReachBottom() {
			if(this.chooseForm==0){
				this.unauditedList = [...this.unauditedList, ...this.unauditedList]
			}else if(this.chooseForm==1){
				this.auditedList = [...this.auditedList, ...this.auditedList]
			}else{
				this.completedList=[...this.completedList, ...this.completedList]
			}
		},
		methods: {
			topCardClick(e) {
				this.chooseForm = e.detail.index;
				console.log(this.chooseForm);
			},
			searchClick(res) {
				uni.showToast({
					title: '搜索：' + res.value,
					icon: 'none'
				})
			},
			actionsClick(result, item, index) {
				if (result == "pass") {
					uni.showModal({
						content: "操作后无法再进行修改，您确定要‘通过’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								item.firstState = 1;
								item.show = false;
								item.modeClass = ['fade', 'slide-right'];
								console.log("发送请求,修改审核状态为‘通过’," + item.contractNo);
							}
						}
					})
				} else if (result == "refuse") {
					uni.showModal({
						content: "操作后无法再进行修改，您确定要‘拒绝’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								item.firstState = 2;
								item.show = false;
								item.modeClass = ['fade', 'slide-right'];
								uni.showToast({
									icon: 'none',
									title: "本单已打回，将通知相关人员进行修改"
								})
								console.log("发送请求,修改审核状态为‘拒绝’，"+ item.contractNo);
							}
						}
					})
				} else {
					uni.navigateTo({
						// 普通参数传输
						url: '/pages/detail/shippingDetail?contractNo=' + item.contractNo
					})
				}
			},
		}
	}
</script>

<style>
	.topBackGround {
		z-index: 100;
		background-repeat: no-repeat;
		background-size: 100%;
		background-position-y: 0px;
		background-image: url(/static/UIImages/OA.png);
		margin-bottom: 65rpx;
	}

	.nullBG {
		height: 330rpx;
	}

	.topCard {
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		top: 210rpx;
		height: 165rpx;
		width: 92%;
		margin-left: 3.5%;
		border-radius: 30rpx;
		border: #00ffff solid 5rpx;
		background-color: #ffffff;
		box-shadow: -5rpx 5rpx 15rpx #00ffff;
		position: absolute;
	}

	.topCardItem {
		height: 150rpx;
		border-radius: 50rpx;
		flex: 1;
	}

	.topCardItemBorder {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.count {
		color: #0081ff;
		font-size: 50rpx;
		margin-bottom: 3%;
	}

	.tips {
		color: #8799a3;
	}

	.formCard {
		/* margin-top: 90rpx; */
	}

	.cardContent {
		display: flex;
		align-items: center;
		flex-direction: column;
		justify-content: center;
	}

	.auditStatusGroup {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		border-top: #DCDCDC solid 1rpx;
		margin-top: 20rpx;
	}

	.auditStatusItem {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		margin-top: 20rpx;
	}

	.actionGroup {
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}

	.actionGroupItem {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		border-top: #DCDCDC solid 1rpx;
	}

	.buttonGroup {
		width: 100%;
		height: 80rpx;
		font-size: 30rpx;
		margin: 20rpx;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}
</style>
