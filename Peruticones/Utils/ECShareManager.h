//
//  ECShareManager.h
//  ClubSuscriptores
//
//  Created by RLoza on 10/28/14.
//  Copyright (c) 2014 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kFlurryApiKey @"Y53JBJS87CSH7F8H9JRY"

#define kTrackingCategory @"Categoria"
#define kTrackingAction @"Acción"
#define kTrackingLabel @"Etiqueta"
#define kTrackingScreen @"Pantalla"
//// Menu
#define kTrackingCategoryButtonMenu @"Boton-menu"
#define kTrackingCategoryButtonCall @"Boton-llamada"
#define kTrackingCategoryButtonCloseDetail @"Boton-regresar"
#define kTrackingCategoryButtonSummary @"Boton-bajada"
#define kTrackingCategoryButtonRegister @"Boton-Registrar"
#define kTrackingCategoryShare @"Compartir"
#define kShareFacebook @"Facebook"
#define kTrackingCategorySend @"Enviar"
#define kTrackingCategoryNotification @"Notificacion"
#define kTrackingCategorySwipe @"Efecto-swipe"
#define kTrackingCategoryVideo @"Reproducir video"
#define kTrackingCategoryDidRead @"final-de-lectura"
#define kTrackingCategoryRelated @"Nota-relacionada"
#define kTrackingCategorySignIn @"Iniciar session"
#define kTrackingCategoryCallTrome @"Alo-Trome"
#define kTrackingCategoryFirstLaunch @"Instalaciones"
#define kTrackingCategoryDidLaunching @"Arranques"
#define kTrackingCategoryUserLimitTimeApp @"Usuarios mas del limite"
#define kTrackingCategorySelect @"Seleccion"

#define kTrackingActionApp @"App"
#define kTrackingActionMenu @"menu"
#define kTrackingActionSummary @"bajada"
#define kTrackingActionDetail @"nota"
#define kTrackingActionVideo @"video"
#define kTrackingActionGallery @"galerias"
#define kTrackingActionArticle @"normal"
#define kTrackingActionParticipate @"participar"
#define kTrackingActionComeBack @"regresar"
#define kTrackingActionSuccess @"exitoso"
#define kTrackingActionShowPass @"Ver contrasena"
#define kTrackingActionFlow @"Flujo"
#define kTrackingActionVideoPlay @"Video-PLAY"
#define kTrackingActionCall @"LLAMADA-GANADORA"
#define kTrackingActionRegisterMe @"Registrarme"
#define kTrackingActionSignInMe @"Ingresar"
#define kTrackingActionCallNoRegister @"llamada-no-registro"
#define kTrackingActionCallTrome @"Llama"

#define kTrackingScreenHome @"INICIO"
#define kTrackingScreenCall @"Llamada Ganadora"
#define kTrackingScreenHelloTrome @"Alo trome"
#define kTrackingScreenNotification @"Notificacion"
#define kTrackingScreenSingUp @"Registrar"
#define kTrackingScreenTerms @"Terminos y condiciones"
#define kTrackingScreenSingIn @"Iniciar sesión"


#define kTypeMediaWhatsappImage @"wai"
#define kTypeMediaWhatsappMovie @"wam"
////

@class Card;
@protocol MFMailComposeViewControllerDelegate;
@protocol GAITracker;

@interface ECShareManager : NSObject

@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

+ (ECShareManager *)shared;

#pragma mark - GA

@property(nonatomic, strong) id<GAITracker> tracker;

+ (void)GACreateTracker;
+ (void)GATrackingWithCategory:(NSString *)category
                        action:(NSString *)action
                         label:(NSString *)label;
+ (void)GATrackingScreenName:(NSString *)ScreenName;

#pragma mark - Flurry

+ (void)FlurryLogEvent:(NSString *)event;
+ (void)startFlurrySessionWithApiKey:(NSString *)apiKey event:(NSString *)event;
+ (void)endFlurrySessionEvent:(NSString *)event;

#pragma mark - Share

+ (void)shareViaFacebookWithImage:(UIImage *)image url:(NSURL *)url text:(NSString *)text inViewController:(__weak UIViewController *)controller;

+ (void)shareViaTwitterWithImage:(UIImage *)image url:(NSURL *)url text:(NSString *)text inViewController:(__weak UIViewController *)controller;

+ (void)shareViaWhatsAppWithType:(NSString *)type file:(NSURL *)fileUrl text:(NSString *)text inControllerView:(UIViewController<UIDocumentInteractionControllerDelegate> __weak *) inControllerView;

+ (void)shareViaEmailWithImage:(UIImage *)image mimeType:(NSString *)mimeType text:(NSString *)text inControllerView:(UIViewController<MFMailComposeViewControllerDelegate> __weak *)inControllerView ;

+ (void)FBMessengerSharerGif:(NSString *)pathFile;

@end
