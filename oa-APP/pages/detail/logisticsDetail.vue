<template>
	<view>
		<view class="logisticsCard">
			<view>
				<uni-row>
					<uni-col class="center" style="border-top: 0rpx solid #00ffff">
						<view>{{logisticsContract.contractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">销售合同编号：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.saleContractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">采购合同编号：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.purchaseContractNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库厂名：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.factoryName}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库日期：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库车牌号：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundCarNo}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库货物量：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundGoodsCount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">卸货货物量：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.unloadedGoodsCount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库皮重：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundTare}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库净重：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundNetWeight}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">出库毛重：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundGrossWeight}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">卸货净重：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.unloadedNetWeight}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<!-- 损耗（出库量-卸货量） -->
						<view class="headLine">损耗：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.outboundGoodsCount-logisticsContract.unloadedGoodsCount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">运费：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.freight}}</view>
					</uni-col>
				</uni-row>
			</view>
			<view>
				<uni-row>
					<uni-col class="center">
						<view>财务审核情况</view>
					</uni-col>
					<view class="financeStatus">
						<view class="contractContent">{{logisticsContract.financeStaff}}</view>
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
								:type="logisticsContract.firstState === 0 ? '' : logisticsContract.firstState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==1">
							<uni-icons :style="'margin-left:15rpx'"
								:type="logisticsContract.secondState === 0 ? '' : logisticsContract.secondState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
						<view v-show="statusIndex==2">
							<uni-icons :style="'margin-left:15rpx'"
								:type="logisticsContract.thridState === 0 ? '' : logisticsContract.thridState===1?'checkmarkempty':'closeempty'"
								size="24" color="#0081ff"></uni-icons>
						</view>
					</view>
				</view>
			</view>
			<view v-show="logisticsContract.firstState==1&&logisticsContract.secondState==1&&logisticsContract.thridState==1">
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
						<view class="contractContent">{{logisticsContract.paymentAmount}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col :span="7" :offset="2">
						<view class="headLine">付款时间：</view>
					</uni-col>
					<uni-col :span="14">
						<view class="contractContent">{{logisticsContract.paymentTime}}</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="subTitle">
						<view>付款流水单截图</view>
					</uni-col>
				</uni-row>
				<uni-row>
					<uni-col class="screenShotCenter">
						<image class="screenShot" mode="aspectFit" :src="logisticsContract.paymentPhoto" @tap="viewscreenShot"></image>
					</uni-col>
				</uni-row>
			</view>
					</view>
			<view v-show="logisticsContract.firstState==0" class="actionGroup">
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
			<view v-show="logisticsContract.firstState!=0" class="actionGroup">
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
				logisticsContract: {
					contractNo: "YS00389367824",
					saleContractNo:"XS00187492233",
					purchaseContractNo:"TR00272839456",
					factoryName:"1号仓库",
					outboundTime:"2022-10-23",
					outboundCarNo: "桂C1431",
					// 出库货物量
					outboundGoodsCount:200,
					// 卸货货物量
					unloadedGoodsCount:185,
					// 出库皮重
					outboundTare:200,
					// 出库净重
					outboundNetWeight:200,
					// 出库毛重
					outboundGrossWeight:200,
					// 卸货净重
					unloadedNetWeight:200,
					// 运费
					freight: 4000,
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
					urls: [this.logisticsContract.paymentPhoto]
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
								that.logisticsContract.firstState = 1;
								console.log("发送请求,修改审核状态为‘通过’," + that.logisticsContract.contractNo);
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
								that.logisticsContract.firstState = 2;
								uni.showToast({
									icon:'none',
									title:"本单已打回，将通知相关人员进行修改"
								})
								console.log("发送请求,修改审核状态为‘拒绝’");
								setTimeout(()=>{
									uni.navigateTo({
										url:'/pages/audit/logistics'
									});
								},1200);
							}
						}
					})
				} else {
					uni.navigateTo({
						url:'/pages/audit/logistics'
					});
				}
			}
		}
	}
</script>

<style>
	.logisticsCard {
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
