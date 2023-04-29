import UIKit

protocol SkeletonLoadable {
    var gradient: CAGradientLayer { get set }
    func setShimmer(layer: CALayer, frame: CGRect)
    func showLoadingAnimation()
    func removeShimmer()
}

extension SkeletonLoadable {
    func removeShimmer() {
        gradient.removeFromSuperlayer()
    }
    
    func setShimmer(layer:CALayer, frame: CGRect) {
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradient)
        
        let animationGroup = self.makeAnimationGroup()
        animationGroup.beginTime = 0.0
        gradient.add(animationGroup, forKey: Constants.Keys.gradientBackground)
        gradient.frame = frame
    }
}

extension SkeletonLoadable {
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        
        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = Constants.Colors.gradientLightGrey.cgColor
        anim1.toValue = Constants.Colors.gradientDarkGrey.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0
        
        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = Constants.Colors.gradientDarkGrey.cgColor
        anim2.toValue = Constants.Colors.gradientLightGrey.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration
        
        let group = CAAnimationGroup()
        group.animations = [anim1,anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false
        
        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        return group
    }
}
