<template>
	<view>
		<view class="searchBox">
			<!-- 			<uni-search-bar v-model="searchValue" bgColor="#ffffff" :focus="false" @confirm="searchClick" @blur="searchBlur" @focus="searchFocus"
				@input="searchInput" @cancel="searchCancel" @clear="searchClear">
			</uni-search-bar> -->
			<uni-search-bar v-model="searchValue" placeholder="请输入要搜索的内容" bgColor="#ffffff" :focus="false"
				@confirm="searchClick">
			</uni-search-bar>
		</view>
		<view class="cardGroup">
			<uni-card :isFull="true" title="采购类" extra="更多>" :style="'margin-top:15rpx'" @tap="toPurchase">
				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="purchaseCardClick">
					<uni-grid-item v-for="(item, index) in purchaseCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid>
				<view class="listItem">
					<uni-list v-for="(item,index) in purchaseList">
						<uni-list-item :title="item.goodsName" :rightText="item.supplier" link="" @tap="toDetail('purchase',item.contractNo)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card>
			<uni-card :isFull="true" title="物流类" extra="更多>" :style="'margin-top:30rpx'" @tap="toLogistics">
				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false"
					@change="logisticsCardClick">
					<uni-grid-item v-for="(item, index) in logisticsCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid>
				<view class="listItem">
					<uni-list v-for="(item,index) in logisticsList">
						<uni-list-item :title="'￥'+item.freight" :rightText="item.factoryName" link="" @tap="toDetail('logistics',item.contractNo)" showArrow>
						</uni-list-item>
					</uni-list>
				</view>
			</uni-card>
			<uni-card :isFull="true" title="物流海运类" extra="更多>" :style="'margin-top:30rpx'" @tap="toShipping">
				<uni-grid :column="3" :highlight="true" :showBorder="false" :square="false" @change="shippingClick">
					<uni-grid-item v-for="(item, index) in shoppingCount" :index="index">
						<view class="numberCardItem">
							<view class="numberCardItemBorder"
								:style="{'border-right':index<2?'#8799a3 solid 1rpx':'0rpx'}">
								<text class="count">{{item.count}}</text>
								<text class="tips">{{item.tips}}</text>
							</view>
						</view>
					</uni-grid-item>
				</uni-grid>
				<view class="listItem">
					<uni-list v-for="(item,index) in shippingList">
						<uni-list-item :title="'￥'+item.expenses" :rightText="item.CarrierCompanyName" link="" @tap="toDetail('shipping',item.contractNo)" showArrow>
<!-- 						<uni-list-item :title="'￥'+item.expenses" :rightText="item.CarrierCompanyName" :link="{url:'/pages/detail/shippingDetail?contractNo='+contractNo}" @tap="toDetail('shipping',item.contractNo)" showArrow> -->
						</uni-list-item>
					</uni-list>
				</view>
			</uni-card>
<!-- 			<uni-card :isFull="true" :padding="0" title="办公类" extra="更多>" :style="'margin-top:15rpx'" @tap="toPurchase">
				<view>
					<uni-list v-for="(item,index) in purchaseList">
						<uni-list-item :title="item.goodsName" :rightText="item.supplier" link="" @tap="toDetail('purchase',item.contractNo)" showArrow></uni-list-item>
					</uni-list>
				</view>
			</uni-card> -->
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				searchValue: "",
				purchaseList: [{
						contractNo: "TR000728394561",
						supplier: "xx食品厂",
						goodsName: "白糖",
					},
					{
						contractNo: "TR000728394562",
						supplier: "ww食品厂",
						goodsName: "蜂蜜",
					}
				],
				purchaseCount: [{
						count: 4,
						tips: "待审批"
					},
					{
						count: 12,
						tips: "已审批"
					},
					{
						count: 10,
						tips: "已完成"
					}
				],
				logisticsList: [{
						contractNo: "TR000728394561",
						factoryName: "7号仓库",
						freight: 4000
					},
					{
						contractNo: "TR000728394562",
						factoryName: "11号仓库",
						freight: 12000
					}
				],
				logisticsCount: [{
						count: 7,
						tips: "待审批"
					},
					{
						count: 3,
						tips: "已审批"
					},
					{
						count: 10,
						tips: "已完成"
					}
				],
				shippingList: [{
						contractNo: "TR000728394561",
						CarrierCompanyName: "东方海外货柜航运有限公司",
						expenses: 13888
					},
					{
						contractNo: "TR000728394562",
						CarrierCompanyName: "蓝波航运有限公司",
						expenses: 13888
					}
				],
				shoppingCount: [{
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
		methods: {
			searchClick(res) {
				uni.showToast({
					title: '搜索：' + res.value,
					icon: 'none'
				})
			},
			// searchInput(res) {
			// 	console.log('----input:', res)
			// },
			// searchClear(res) {
			// 	uni.showToast({
			// 		title: 'clear事件，清除值为：' + res.value,
			// 		icon: 'none'
			// 	})
			// },
			// searchBlur(res) {
			// 	uni.showToast({
			// 		title: 'blur事件，输入值为：' + res.value,
			// 		icon: 'none'
			// 	})
			// },
			// searchFocus(e) {
			// 	uni.showToast({
			// 		title: 'focus事件，输出值为：' + e.value,
			// 		icon: 'none'
			// 	})
			// },
			// searchCancel(res) {
			// 	uni.showToast({
			// 		title: '点击取消，输入值为：' + res.value,
			// 		icon: 'none'
			// 	})
			// },
			purchaseCardClick(e) {
				if(e.detail.index==0){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/purchase'
					})
				}else if(e.detail.index==1){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/purchase?chooseForm='+1
					})
				}else{
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/purchase?chooseForm='+2
					})
				}
			},
			logisticsCardClick(e) {
				if(e.detail.index==0){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/logistics'
					})
				}else if(e.detail.index==1){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/logistics?chooseForm='+1
					})
				}else{
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/logistics?chooseForm='+2
					})
				}
			},
			shippingClick(e) {
				if(e.detail.index==0){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/shipping'
					})
				}else if(e.detail.index==1){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/shipping?chooseForm='+1
					})
				}else{
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/audit/shipping?chooseForm='+2
					})
				}
			},
			toPurchase(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/purchase"
					})
				}
			},
			toLogistics(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/logistics"
					})
				}
			},
			toShipping(e) {
				if (e == "extra") {
					uni.navigateTo({
						url: "/pages/audit/shipping"
					})
				}
			},
			toDetail(type,contractNo){
				if(type=="purchase"){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/detail/purchaseDetail?contractNo='+contractNo
					})
				}else if(type=="logistics"){
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/detail/logisticsDetail?contractNo='+contractNo
					})
				}else{
					uni.navigateTo({
						// 普通参数传输
						url:'/pages/detail/shippingDetail?contractNo='+contractNo
					})
				}
			}
		}
	}
</script>

<style>
	.numberCard {
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

	.numberCardItem {
		height: 150rpx;
		border-radius: 50rpx;
		flex: 1;
	}

	.numberCardItemBorder {
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

	.listItem {
		margin-top: 20rpx
	}
</style>
