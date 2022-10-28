<template>
	<view>
		<view class="shippingCard">
			<view>
				<uni-row>
					<uni-col class="center" style="border-top: 0rpx solid #00ffff">
						<view>{{shippingContract.contractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">运输合同编号：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.logtisticsContractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">装箱日期：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.packingTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">集装箱号：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.containerNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">铅封号：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.sealNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">理货员：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.tallyClerk}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">运输相关放方：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.release}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">起运承运车队：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.departureFleet}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">承运船公司：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.carrierCompanyName}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">目的港承运车队：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.destinationPortFleet}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">费用：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.expenses}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="subTitle">
						<view>合同</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="screenShotCenter">
						<image class="screenShot" mode="aspectFit" :src="shippingContract.contractPhoto" @tap="viewContractPhoto"></image>
					</uni-col>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>财务审核情况</view>
					</uni-col>
					<view class="financeStatus">
						<view class="contractContent">{{shippingContract.financeStaff}}</view>
						<uni-icons :style="'margin-left:15rpx'" type="checkmarkempty" size="24" color="#0081ff">
						</uni-icons>
					</view>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>董事会审核情况</view>
					</uni-col>
				</uni-row>
				<view class="auditStatusGroup">
					<view v-for="(statusItem,statusIndex) in directorList" :key="statusItem.directorId"
						class="auditStatusItem">
						<view class="contractContent">{{statusItem.directorName}}</view>
						<view v-show="statusIndex==0">
							<uni-icons :style="'margin-left:15rpx'"
								:type="shippingContract.firstState === 0 ? '' : shippingContract.firstState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==1">
							<uni-icons :style="'margin-left:15rpx'"
								:type="shippingContract.secondState === 0 ? '' : shippingContract.secondState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==2">
							<uni-icons :style="'margin-left:15rpx'"
								:type="shippingContract.thridState === 0 ? '' : shippingContract.thridState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
					</view>
				</view>
			</view>
			<view v-show="shippingContract.firstState==1&&shippingContract.secondState==1&&shippingContract.thridState==1">
				<uni-row>
					<uni-col class="center">
						<view>出纳付款情况</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">付款金额：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.paymentAmount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="8" :offset="2">
						<view class="headLine">付款时间：</view>
					</uni-col>
					<uni-col :span="13">
						<view class="contractContent">{{shippingContract.paymentTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="subTitle">
						<view>付款流水单截图</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="screenShotCenter">
						<image class="screenShot" mode="aspectFit" :src="shippingContract.paymentPhoto" @tap="viewscreenShot"></image>
					</uni-col>
				</uni-row>
			</view>
					</view>
			<view v-show="shippingContract.firstState==0" class="actionGroup">
				<view class="actionGroupItem" @tap="actionsClick('pass')">
					<button class="buttonGroup" type="primary">通过</button>
				</view>
<!-- 				<view class="actionGroupItem" @tap="actionsClick('refuse')">
					<button class="buttonGroup" type="warn">拒绝</button>
				</view> -->
				<view class="actionGroupItem" @tap="actionsClick('back')">
					<button class="buttonGroup">返回</button>
				</view>
			</view>
			<view v-show="shippingContract.firstState!=0" class="actionGroup">
				<view class="actionGroupItem" @tap="actionsClick('bcak')">
					<button class="buttonGroup">返回</button>
				</view>
			</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				shippingContract: {
					contractNo: "HY00389367824",
					logtisticsContractNo:"YS00187492233",
					// 装箱日期
					packingTime:"2022-10-23",
					// 集装箱号
					containerNo:"EASU9809490",
					// 铅封号
					sealNo: "C56765",
					// 理货员
					tallyClerk:"何某某",
					// 运输相关放方
					release:"新南海关",
					// 起运承运车队
					departureFleet:"新南物流车队",
					// 承运船公司
					carrierCompanyName: "东方海外货柜航运有限公司",
					// 目的港承运车队
					destinationPortFleet:"老北物流车队",
					// 费用
					expenses: 13888,
					financeStaff: "李某某",
					firstState: 0,
					secondState: 1,
					thridState: 1,
					paymentAmount: 27000,
					paymentTime: "2022-10-23",
					paymentPhoto: "/static/UIImages/purchaseScreenShot.png",
					contractPhoto: "/static/UIImages/contract.png"
				},
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
			}
		},
		// data为形参
		onLoad(data) {
			// 普通参数接收
			console.log("合同号：" + data.contractNo);
		},
		onNavigationBarButtonTap(){
			uni.switchTab({
				url:"/pages/MainInterface/audit"
			})
		},
		methods: {
			viewscreenShot(){
				uni.previewImage({
					urls: [this.shippingContract.paymentPhoto]
				})
			},
			viewContractPhoto(){
				uni.previewImage({
					urls: [this.shippingContract.contractPhoto]
				})
			},
			actionsClick(result) {
				const that=this;
				if (result == "pass") {
					uni.showModal({
						content: "操作后无法再进行修改，您确定要‘通过’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								that.shippingContract.firstState = 1;
								console.log("发送请求,修改审核状态为‘通过’," + that.shippingContract.contractNo);
								// setTimeout(()=>{
								// 	this.unauditedList.splice(index, 1);
								// 	console.log(this.unauditedList);
								// },500);
							}
						}
					})
				} else if (result == "refuse") {
					uni.showModal({
						content: "操作后无法再进行修改，您确定要‘拒绝’该单吗？",
						showCancel: true,
						success(res) {
							if (res.confirm) {
								that.shippingContract.firstState = 2;
								uni.showToast({
									icon:'none',
									title:"本单已打回，将通知相关人员进行修改"
								})
								console.log("发送请求,修改审核状态为‘拒绝’");
								setTimeout(()=>{
									uni.navigateTo({
										url:'/pages/audit/shipping'
									});
								},1200);
							}
						}
					})
				} else {
					uni.navigateBack({
						delta:1
					});
					// uni.navigateTo({
					// 	url:'/pages/audit/shipping'
					// });
				}
			}
		}
	}
</script>

<style>
	.shippingCard {
		width: 92%;
		margin-left: 3.5%;
		border-radius: 30rpx;
		border: #00ffff solid 5rpx;
		background-color: #ffffff;
	}

	.center {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: #0081ff;
		font-size: 32rpx;
		font-weight: bolder;
		border-top: 5rpx solid #00ffff;
		padding-top: 5rpx;
		padding-bottom: 5rpx;
	}

	.headLine {
		color: #009999;
		font-size: 28rpx;
		font-weight: bolder;
		margin-top: 10rpx;
		margin-bottom: 10rpx;
	}
	
	.contractContent{
		font-size: 28rpx;
		margin-top: 10rpx;
		margin-bottom: 10rpx;
	}
	
	.financeStatus{
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
/* 		padding-top: 10rpx; */
	}

	.auditStatusGroup {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
	}

	.auditStatusItem {
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: row;
		justify-content: center;
		/* margin-top: 10rpx; */
	}

	.subTitle {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
		color: #0081ff;
		font-size: 28rpx;
		font-weight: bolder;
	}

	.screenShotCenter {
		position: relative;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}
	
	.screenShot{
		height: 640rpx;
		width: 320rpx;
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
