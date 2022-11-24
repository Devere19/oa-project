<template>
	<view class="center">
		<view class="userInfo">
			<image class="logo-img" :src="user.userPhoto"></image>
			<!-- <image class="logo-img" :src="user.userPhoto" @tap="viewUserAvatar(user.userPhoto)"></image> -->
			<view class="logo-title">
				<text class="user-name">{{user.nickName}}</text>
			</view>
		</view>
<!-- 		<uni-grid class="grid" :column="4" :showBorder="false" :square="true">
			<uni-grid-item class="item" v-for="(item,index) in gridList" @tap.native="tapGrid(item.text)"
				:key="index">
				<uni-icons class="icon" color="#007AFF" :type="item.icon" size="26"></uni-icons>
				<text class="text">{{item.text}}</text>
			</uni-grid-item>
		</uni-grid> -->
		<uni-list class="center-list" v-for="(sublist , index) in ucenterList" :key="index">
			<uni-list-item class="functionItem" v-for="(item,i) in sublist" :title="item.title" link :rightText="item.rightText" :key="i"
				:clickable="true" :to="item.to" :show-extra-icon="true" :extraIcon="{type:item.icon,color:'#999'}"
				@tap="tapList(item.title)">
			</uni-list-item>
		</uni-list>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				dataObject: null,
				times: 0,
				user: {
					userId:'',
					nickName: '',
					userPhoto: "/static/UIImages/defaultAvatar.png"
				},
				gridList: [{
						"text": "钱包",
						"icon": "wallet-filled"
					},
					{
						"text": "日志",
						"icon": "calendar-filled"
					},
					{
						"text": "下载",
						"icon": "cloud-download-filled"
					},
					{
						"text": "收藏",
						"icon": "star-filled"
					}
				],
				ucenterList: [
					[{
							"title": "账号管理",
							// "to": '/uni_modules/uni-feedback/pages/opendb-feedback/opendb-feedback',
							"icon": "compose"
						},
						{
							"title": "联系我们",
							// "to": '/pages/ucenter/settings/settings',
							"icon": "email"
						}
					],
					[{
						"title": "退出登录",
						// "to": '/pages/ucenter/about/about',
						"icon": "paperplane"
					}]
				]
			}
		},
		mounted() {
			//页面加载完成，获取本地存储的用户信息
			const userData = uni.getStorageSync('userInfo');
			if(userData){
				this.user.userId=userData.userId;
				this.user.nickName=userData.nickName;
			}
		},
		onShow() {
			
		},
		methods: {
			/**
			 * 个人中心项目列表点击事件
			 */
			tapGrid(item) {
				uni.showToast({
					// title: '你点击了，第' + (index + 1) + '个',
					title: '你点击了' + item,
					icon: 'none'
				})
			},
			viewUserAvatar(avatar) {
				uni.previewImage({
					urls: [avatar]
				})
			},
			tapList(item) {
				if(item=="退出登录"){
					uni.reLaunch({
						url: '/pages/login/login?data=exit'
					});
				}else{
					// uni.showToast({
					// 	title: '你点击了' + item,
					// 	icon: 'none'
					// })
					uni.showToast({
						title: '该功能暂未开发',
						icon: 'none'
					})
				}
			},
		}
	}
</script>

<style lang="scss" scoped>
	/* #ifndef APP-NVUE */
	view {
		display: flex;
		box-sizing: border-box;
		flex-direction: column;
	}

	page {
		background-color: #f8f8f8;
	}

	/* #endif*/

	.center {
		flex: 1;
		flex-direction: column;
		background-color: #f8f8f8;
	}

	.userInfo {
		padding: 2%;
		padding-top: 10%;
		background-image: url(/static/UIImages/userCenter.png);
		flex-direction: column;
		align-items: center;
		background-repeat: no-repeat;
		background-position-y: -75px;
		background-color: #ffffff;
	}

	.logo-img {
		width: 140rpx;
		height: 140rpx;
		// 圆形
		border-radius: 140rpx;
	}

	.logo-title {
		flex: 1;
		align-items: center;
		justify-content: space-between;
		flex-direction: row;
	}

	.user-name {
		height: 80rpx;
		line-height: 80rpx;
		font-size: 32rpx;
		font-weight: bolder;
		color: #000000;
	}

	.center-list {
		margin-bottom: 20rpx;
		background-color: #f9f9f9;
	}

	.center-list-cell {
		width: 100%;
		background-color: #007AFF;
		height: 25rpx;
	}

	.grid {
		background-color: #FFFFFF;
		margin-bottom: 20rpx;
	}

	.uni-grid .text {
		font-size: 30rpx;
		height: 50rpx;
		line-height: 50rpx;
		color: #817f82;
	}

	.uni-grid .item ::v-deep .uni-grid-item__box {
		justify-content: center;
		align-items: center;
	}


	/*修改边线粗细示例*/
	/* #ifndef APP-NVUE */
	.center-list ::v-deep .uni-list--border:after {
		-webkit-transform: scaleY(0.2);
		transform: scaleY(0.2);
		margin-left: 80rpx;
	}

	.center-list ::v-deep .uni-list--border-top,
	.center-list ::v-deep .uni-list--border-bottom {
		display: none;
	}

	/* #endif */
	
	.functionItem{
		height: 100rpx;
	}
</style>
