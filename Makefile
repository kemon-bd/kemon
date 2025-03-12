deploy:
	@echo "Publishing android to production..."
	cd android && fastlane production && cd ..

	@clear

	@echo "Publishing iOS to testflight..."
	cd ios && pod update && cd .. && flutter build ipa --release && cd ios && fastlane beta && cd ..

	@clear

	@echo "Deployed successfully! 🚀🚀🚀"

.PHONY: deploy

deploy-android:
	@echo "Publishing android to production..."
	cd android && fastlane production && cd ..

	@clear

	@echo "Deployed successfully! 🚀🚀🚀"

.PHONY: deploy-android

deploy-android-test:
	@echo "Publishing android to internal test..."
	cd android && fastlane internal && cd ..

	@clear

	@echo "Deployed successfully! 🚀🚀🚀"

.PHONY: deploy-android

deploy-ios:
	@echo "Publishing iOS to testflight..."
	cd ios && pod update && cd .. && flutter build ipa --release && cd ios && fastlane beta && cd ..

	@clear

	@echo "Deployed successfully! 🚀🚀🚀"

.PHONY: deploy-ios