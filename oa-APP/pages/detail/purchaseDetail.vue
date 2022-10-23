<template>
	<view>
		<view class="purchaseCard">
			<view>
				<uni-row>
					<uni-col class="center" style="border-top: 0rpx solid #00ffff">
						<view>{{purchaseContract.contractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">供货商公司名：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.supplier}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">己方公司名：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.ownCompanyName}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">入库时间：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.InboundTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">采购货物名称：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.goodsName}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">采购货物总量：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.goodsCount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">货物单位：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.goodsUnit}}</view>
					</uni-col>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>财务审核情况</view>
					</uni-col>
					<view class="financeStatus">
						<view class="contractContent">{{purchaseContract.financeStaff}}</view>
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
								:type="purchaseContract.firstState === 0 ? '' : purchaseContract.firstState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==1">
							<uni-icons :style="'margin-left:15rpx'"
								:type="purchaseContract.secondState === 0 ? '' : purchaseContract.secondState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==2">
							<uni-icons :style="'margin-left:15rpx'"
								:type="purchaseContract.thridState === 0 ? '' : purchaseContract.thridState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
					</view>
				</view>
			</view>
			<view v-show="purchaseContract.firstState==1&&purchaseContract.secondState==1&&purchaseContract.thridState==1">
				<uni-row>
					<uni-col class="center">
						<view>出纳付款情况</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">付款金额：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.paymentAmount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">付款时间：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{purchaseContract.paymentTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="subTitle">
						<view>付款流水单截图</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="screenShotCenter">
						<image class="screenShot" mode="aspectFit" :src="purchaseContract.paymentPhoto" @tap="viewscreenShot"></image>
					</uni-col>
				</uni-row>
			</view>
					</view>
			<view v-show="purchaseContract.firstState==0" class="actionGroup">
				<view class="actionGroupItem" @tap="actionsClick('pass')">
					<button class="buttonGroup" type="primary">通过</button>
				</view>
				<view class="actionGroupItem" @tap="actionsClick('refuse')">
					<button class="buttonGroup" type="warn">拒绝</button>
				</view>
				<view class="actionGroupItem" @tap="actionsClick('back')">
					<button class="buttonGroup">返回</button>
				</view>
			</view>
			<view v-show="purchaseContract.firstState!=0" class="actionGroup">
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
				purchaseContract: {
					contractNo: "TR00272839456",
					supplier: "桂林骏泰信息科技有限公司",
					ownCompanyName: "广西丰沣顺国际物流有限公司",
					InboundTime: "2022-10-09",
					goodsName: "白糖",
					goodsCount: 200,
					goodsUnit: "吨",
					financeStaff: "李某某",
					firstState: 0,
					secondState: 1,
					thridState: 1,
					paymentAmount: 27000,
					paymentTime: "2022-10-23",
					paymentPhoto: "/static/UIImages/purchaseScreenShot.png"
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
		methods: {
			viewscreenShot(){
				uni.previewImage({
					urls: [this.purchaseContract.paymentPhoto]
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
								that.purchaseContract.firstState = 1;
								console.log("发送请求,修改审核状态为‘通过’," + that.purchaseContract.contractNo);
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
								that.purchaseContract.firstState = 2;
								uni.showToast({
									icon:'none',
									title:"本单已打回，将通知相关人员进行修改"
								})
								console.log("发送请求,修改审核状态为‘拒绝’");
								setTimeout(()=>{
									uni.navigateTo({
										url:'/pages/audit/purchase'
									});
								},1200);
							}
						}
					})
				} else {
					// uni.navigateBack({
					// 	delta:2
					// })
					uni.navigateTo({
						url:'/pages/audit/purchase'
					});
				}
			}
		}
	}
</script>

<style>
	.purchaseCard {
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
